import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/core/network/dio_client.dart';
import 'package:lolo/features/ai_messages/domain/entities/generated_message_entity.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_length.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_request_entity.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_tone.dart';

/// Contract for AI message generation and history operations.
abstract class MessageRepository {
  Future<Either<Failure, GeneratedMessageEntity>> generateMessage(
    MessageRequestEntity request,
  );

  Future<Either<Failure, GeneratedMessageEntity>> regenerateMessage(
    String originalMessageId,
  );

  Future<Either<Failure, void>> rateMessage({
    required String messageId,
    required int rating,
  });

  Future<Either<Failure, void>> toggleFavorite(String messageId);

  Future<Either<Failure, List<GeneratedMessageEntity>>> getMessageHistory({
    int page = 1,
    int pageSize = 20,
    bool? favoritesOnly,
    MessageMode? modeFilter,
    String? searchQuery,
  });

  Future<Either<Failure, ({int used, int limit})>> getUsageCount();
}

/// API-backed implementation that calls the Cloud Functions backend
/// to generate messages with GPT-4o-mini. Falls back to local
/// templates if the API call fails.
class MessageRepositoryImpl implements MessageRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Dio _dio;

  MessageRepositoryImpl({
    required Dio dio,
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _dio = dio,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final _random = Random();

  Future<String> _getPartnerName() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return 'her';
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      return doc.data()?['partnerNickname'] as String? ??
          doc.data()?['partnerName'] as String? ??
          'her';
    } catch (_) {
      return 'her';
    }
  }

  @override
  Future<Either<Failure, GeneratedMessageEntity>> generateMessage(
    MessageRequestEntity request,
  ) async {
    try {
      // Try API call first
      final response = await _dio.post<Map<String, dynamic>>(
        '/messages/generate',
        data: {
          'mode': request.mode.name,
          'tone': request.tone.name,
          'length': request.length.name,
          'language': request.languageCode,
          'includePartnerName': request.includePartnerName,
          'humorLevel': request.humorLevel,
          if (request.contextText != null) 'contextText': request.contextText,
        },
      );

      final data = response.data?['data'] as Map<String, dynamic>?;
      if (data == null) throw Exception('Empty response from API');

      final msg = GeneratedMessageEntity(
        id: data['id'] as String? ?? 'api_${DateTime.now().millisecondsSinceEpoch}',
        content: data['content'] as String? ?? '',
        mode: request.mode,
        tone: request.tone,
        length: request.length,
        createdAt: DateTime.now(),
        modelBadge: data['modelBadge'] as String? ?? 'GPT-4o mini',
        languageCode: request.languageCode,
        includePartnerName: request.includePartnerName,
      );

      return Right(msg);
    } catch (e) {
      // Fallback to local templates if API fails
      return _generateLocally(request);
    }
  }

  /// Local fallback when API is unavailable.
  Future<Either<Failure, GeneratedMessageEntity>> _generateLocally(
    MessageRequestEntity request,
  ) async {
    try {
      final partnerName =
          request.includePartnerName ? await _getPartnerName() : null;
      final content =
          _pickTemplate(request.mode, request.tone, request.length, partnerName);

      final msg = GeneratedMessageEntity(
        id: 'local_${DateTime.now().millisecondsSinceEpoch}',
        content: content,
        mode: request.mode,
        tone: request.tone,
        length: request.length,
        createdAt: DateTime.now(),
        modelBadge: 'LOLO',
        languageCode: request.languageCode,
        includePartnerName: request.includePartnerName,
      );

      // Save to Firestore history
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('messages')
            .doc(msg.id)
            .set({
          'content': content,
          'mode': request.mode.name,
          'tone': request.tone.name,
          'length': request.length.name,
          'languageCode': request.languageCode,
          'isFavorite': false,
          'rating': 0,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return Right(msg);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GeneratedMessageEntity>> regenerateMessage(
    String originalMessageId,
  ) async {
    return generateMessage(const MessageRequestEntity(
      mode: MessageMode.romantic,
      tone: MessageTone.heartfelt,
      length: MessageLength.medium,
    ));
  }

  @override
  Future<Either<Failure, void>> rateMessage({
    required String messageId,
    required int rating,
  }) async {
    try {
      // Try API first
      try {
        await _dio.post<dynamic>(
          '/messages/$messageId/feedback',
          data: {'rating': rating},
        );
      } catch (_) {
        // Fallback to direct Firestore write
        final uid = _auth.currentUser?.uid;
        if (uid != null) {
          await _firestore
              .collection('users')
              .doc(uid)
              .collection('messages')
              .doc(messageId)
              .update({'rating': rating});
        }
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(String messageId) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        final doc = await _firestore
            .collection('users')
            .doc(uid)
            .collection('messages')
            .doc(messageId)
            .get();
        final current = doc.data()?['isFavorite'] as bool? ?? false;
        await doc.reference.update({'isFavorite': !current});
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GeneratedMessageEntity>>> getMessageHistory({
    int page = 1,
    int pageSize = 20,
    bool? favoritesOnly,
    MessageMode? modeFilter,
    String? searchQuery,
  }) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return const Right([]);

      var query = _firestore
          .collection('users')
          .doc(uid)
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .limit(pageSize);

      if (favoritesOnly == true) {
        query = query.where('isFavorite', isEqualTo: true);
      }
      if (modeFilter != null) {
        query = query.where('mode', isEqualTo: modeFilter.name);
      }

      final snap = await query.get();
      final messages = snap.docs.map((doc) {
        final d = doc.data();
        return GeneratedMessageEntity(
          id: doc.id,
          content: d['content'] as String? ?? '',
          mode: MessageMode.values.firstWhere(
            (e) => e.name == d['mode'],
            orElse: () => MessageMode.romantic,
          ),
          tone: MessageTone.values.firstWhere(
            (e) => e.name == d['tone'],
            orElse: () => MessageTone.heartfelt,
          ),
          length: MessageLength.values.firstWhere(
            (e) => e.name == d['length'],
            orElse: () => MessageLength.medium,
          ),
          createdAt: (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
          rating: d['rating'] as int? ?? 0,
          isFavorite: d['isFavorite'] as bool? ?? false,
          languageCode: d['languageCode'] as String?,
        );
      }).toList();

      return Right(messages);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ({int used, int limit})>> getUsageCount() async {
    return const Right((used: 0, limit: -1));
  }

  // ---------------------------------------------------------------------------
  // Local message templates (fallback)
  // ---------------------------------------------------------------------------

  String _pickTemplate(
    MessageMode mode,
    MessageTone tone,
    MessageLength length,
    String? name,
  ) {
    final templates = _templates[mode] ?? _templates[MessageMode.romantic]!;
    final toneTemplates = templates[tone] ?? templates[MessageTone.heartfelt]!;
    final picked = toneTemplates[_random.nextInt(toneTemplates.length)];

    var msg = name != null
        ? picked.replaceAll('{name}', name)
        : picked.replaceAll('{name}', 'babe');

    if (length == MessageLength.short && msg.length > 120) {
      final dot = msg.indexOf('. ');
      if (dot > 0) msg = '${msg.substring(0, dot + 1)}';
    } else if (length == MessageLength.long) {
      msg = '$msg\n\nYou deserve to hear this every single day.';
    }

    return msg;
  }

  static const _templates = <MessageMode, Map<MessageTone, List<String>>>{
    MessageMode.romantic: {
      MessageTone.heartfelt: [
        'Every moment with you feels like a gift I never knew I needed, {name}. You make my world brighter just by being in it.',
        'I fall in love with you a little more each day, {name}. The way you laugh, the way you care — it all takes my breath away.',
        'You are my favorite hello and my hardest goodbye, {name}. I hope you know how deeply you are loved.',
      ],
      MessageTone.playful: [
        'If loving you was a job, {name}, I\'d be the most dedicated employee — zero sick days, overtime every night! 😄',
        'Hey {name}, just so you know, my heart does this little flip thing every time I see your name on my phone. It\'s honestly embarrassing.',
        'I\'d swipe right on you a thousand times, {name}. Actually, I\'d delete the app because why would I need it when I have you?',
      ],
      MessageTone.direct: [
        'I love you, {name}. Simply and completely. You\'re the best thing that ever happened to me.',
        '{name}, you need to know something — you are the reason I look forward to every single day.',
        'No fancy words needed. {name}, you\'re my person. Today, tomorrow, always.',
      ],
      MessageTone.poetic: [
        'Like the moon needs the night to shine its brightest, {name}, my heart needs you to feel complete. You are my beautiful constant.',
        'In the garden of my life, {name}, you are the flower that never fades — blooming with grace, filling every corner with warmth.',
        'If love were a language, {name}, yours would be the most beautiful poetry — written in whispers, felt in the silence between heartbeats.',
      ],
    },
    MessageMode.apology: {
      MessageTone.heartfelt: [
        'I\'m sorry, {name}. I know my words hurt you, and that\'s the last thing I ever want to do. You deserve better, and I\'m going to be better.',
        '{name}, I was wrong. I should have listened instead of reacted. Your feelings matter to me more than being right ever could.',
        'I hate that I made you feel that way, {name}. I\'m not perfect, but my love for you is real, and I\'m sorry I didn\'t show it.',
      ],
      MessageTone.playful: [
        '{name}, I messed up. On a scale of 1 to 10, I\'d rate my mistake a solid 8... but my apology sincerity? That\'s a 100. Forgive me?',
        'Dear {name}, this is my formal, notarized, triple-stamped apology. I was a dummy. You were right. Can I make it up to you with your favorite food?',
        'Plot twist, {name}: I was the villain in today\'s episode. I\'m sorry. Can we skip to the part where we make up? 🤗',
      ],
      MessageTone.direct: [
        'I\'m sorry, {name}. No excuses. I was wrong and I own that completely.',
        '{name}, I apologize. I should have handled that differently. Tell me how I can make it right.',
        'I messed up, {name}. You didn\'t deserve that. I\'m sorry and I mean it.',
      ],
      MessageTone.poetic: [
        'If my words were rain, {name}, I wish I could wash away the hurt I caused and leave only the warmth of how much I truly care for you.',
        'In the story of us, {name}, today was a chapter I wish I could rewrite. But I promise — the next pages will be filled with the love you deserve.',
        'Forgive me, {name}, for the clouds I brought to your sky. Let me be the sunlight that makes it right again.',
      ],
    },
    MessageMode.appreciation: {
      MessageTone.heartfelt: [
        'Thank you for being you, {name}. You make everything better — my days, my life, my heart.',
        '{name}, I don\'t say it enough, but I notice everything you do. Every little thing. And I\'m so grateful for you.',
        'The way you love, {name}, is something extraordinary. Thank you for choosing to share that love with me.',
      ],
      MessageTone.playful: [
        '{name}, you\'re basically a superhero. Your powers? Making me smile, keeping me sane, and looking absolutely amazing doing it.',
        'If there was an award for World\'s Best Partner, {name}, you\'d win it every year. And I\'d be your biggest fan in the audience.',
        'Fun fact, {name}: Scientists have confirmed that you are 100% amazing. Source: me, just now. Very scientific. 🔬',
      ],
      MessageTone.direct: [
        '{name}, I appreciate you. Everything you do, everything you are. I don\'t take it for granted.',
        'You make my life better, {name}. That\'s not flattery — that\'s a fact. Thank you.',
        'I see how hard you try, {name}, and I want you to know it matters. You matter.',
      ],
      MessageTone.poetic: [
        'You are the quiet magic in my everyday, {name}. Like the sun that rises without asking for applause, you shine — and my world is brighter for it.',
        'If gratitude were stars, {name}, the sky wouldn\'t be big enough to hold all the ones you\'ve given me reason to count.',
        'In a world of noise, {name}, your love is the melody that makes everything make sense.',
      ],
    },
    MessageMode.flirty: {
      MessageTone.heartfelt: [
        'You have no idea what you do to me, {name}. One look from you and my whole day changes for the better.',
        '{name}, I was trying to focus today, but then I thought about your smile and... well, that was the end of productivity.',
        'Is it possible to miss someone who\'s right there? Because every time you leave the room, {name}, I count the seconds.',
      ],
      MessageTone.playful: [
        'Hey {name}, is it hot in here or is it just you? Actually, it\'s definitely you. It\'s always you. 🔥',
        '{name}, I have a confession: I\'ve been staring at your photo for the last 5 minutes. Don\'t judge me, you\'re gorgeous.',
        'Warning, {name}: Excessive cuteness detected. Please tone it down. Just kidding — never change. 😏',
      ],
      MessageTone.direct: [
        'I can\'t stop thinking about you, {name}. Just thought you should know.',
        '{name}, you looked incredible today. Like, stopped-me-in-my-tracks incredible.',
        'Come here, {name}. I need to hold you. That\'s not a request.',
      ],
      MessageTone.poetic: [
        'Your eyes are the kind of beautiful that makes poets run out of words, {name}. Lucky for you, I\'ll never stop trying to find new ones.',
        'If desire were a color, {name}, it would be painted in every shade of you.',
        'You walk into a room, {name}, and suddenly the air gets sweeter. That\'s the kind of magic you carry.',
      ],
    },
    MessageMode.encouragement: {
      MessageTone.heartfelt: [
        'I believe in you, {name}. More than you know. Whatever you\'re facing, you have the strength to get through it.',
        '{name}, don\'t forget how far you\'ve come. You\'ve overcome so much already, and I\'m so proud of you.',
        'You are stronger than you think, {name}. And even on the days you don\'t feel it, I\'ll believe it enough for both of us.',
      ],
      MessageTone.playful: [
        '{name}, you\'ve got this! And if you don\'t, I\'ll be right here with snacks and a pep talk. Either way, we win. 💪',
        'Reminder, {name}: You\'re a queen. Queens don\'t quit. Now go conquer whatever today throws at you!',
        '{name}, you\'re basically unstoppable. The universe just hasn\'t caught up yet. Give it a minute.',
      ],
      MessageTone.direct: [
        'You can do this, {name}. I\'ve seen what you\'re capable of and it\'s extraordinary.',
        'Don\'t doubt yourself, {name}. You\'re more capable than you give yourself credit for.',
        'Keep going, {name}. The hard part is almost over, and I\'m right here with you.',
      ],
      MessageTone.poetic: [
        'Even the tallest mountains were climbed one step at a time, {name}. And darling, you\'re already halfway to the summit.',
        'The fire in your soul, {name}, is brighter than any storm. Let it burn. Let it carry you forward.',
        'Like a diamond formed under pressure, {name}, this challenge is only making you shine brighter.',
      ],
    },
    MessageMode.missYou: {
      MessageTone.heartfelt: [
        'I miss you, {name}. Not just your presence, but the way everything feels right when you\'re here.',
        'The distance between us is just space, {name}. My heart is right there with you, always.',
        '{name}, every song sounds like it\'s about you today. I miss your laugh, your voice, everything.',
      ],
      MessageTone.playful: [
        '{name}, I miss you so much I just talked to your photo. It didn\'t answer. Very rude. Come back soon! 😤',
        'Missing you level: just Googled "how to teleport." No luck yet, {name}, but I\'ll keep you posted.',
        'My pillow is a terrible replacement for you, {name}. It doesn\'t hug back and it\'s not nearly as cute.',
      ],
      MessageTone.direct: [
        'I miss you, {name}. Simple as that. Come home soon.',
        '{name}, it\'s too quiet without you. I need you here.',
        'Every minute without you feels too long, {name}. I miss you.',
      ],
      MessageTone.poetic: [
        'The hours without you, {name}, stretch like shadows at sunset — long and aching for the light only you bring.',
        'I carry your absence like a song I can\'t get out of my head, {name}. Beautiful, haunting, and mine.',
        'Missing you is the quiet ache between heartbeats, {name} — gentle but constant, like the tide longing for the shore.',
      ],
    },
    MessageMode.goodMorning: {
      MessageTone.heartfelt: [
        'Good morning, {name}. I woke up thinking about how lucky I am to have you in my life. Have a beautiful day.',
        'Rise and shine, {name}. I hope your day is as wonderful as the smile you give me every morning.',
        'Good morning, my love. {name}, you make every day worth waking up for.',
      ],
      MessageTone.playful: [
        'Good morning, {name}! ☀️ The sun is up, the coffee is brewing, and you\'re still the most beautiful thing in my day.',
        'Wakey wakey, {name}! The world needs your sparkle today. And by the world, I mostly mean me.',
        'Morning, {name}! Fun fact: you\'re the reason I smile before my first cup of coffee. That\'s basically a miracle.',
      ],
      MessageTone.direct: [
        'Good morning, {name}. I love you. Have an amazing day.',
        'Morning, {name}. Just wanted to be the first to remind you that you\'re incredible.',
        'Hey {name}, good morning. You\'re on my mind first thing, as always.',
      ],
      MessageTone.poetic: [
        'The dawn whispers your name, {name}, as sunlight paints the sky in shades of gold — just like the warmth you bring to my life each morning.',
        'Good morning, {name}. May today greet you as gently as you greet my heart — with grace, beauty, and endless possibility.',
        'Each sunrise is a love letter from the universe, {name}, reminding me that another day with you is the greatest gift.',
      ],
    },
    MessageMode.goodNight: {
      MessageTone.heartfelt: [
        'Good night, {name}. As the stars come out, I want you to know — you\'re the brightest part of my every day.',
        'Sleep well, {name}. I\'ll be dreaming of you tonight, just like every other night.',
        'Good night, my love. {name}, I hope you feel as loved as you are right now, wrapped in all my warmth from afar.',
      ],
      MessageTone.playful: [
        'Night night, {name}! 🌙 Don\'t let the bedbugs bite. If they do, tell them your boyfriend said to back off.',
        'Sweet dreams, {name}! Try to dream about me. I\'ll rate your dreams in the morning. ⭐',
        'Good night, {name}. My pillow wants you to know it\'s jealous of yours. Sleep tight!',
      ],
      MessageTone.direct: [
        'Good night, {name}. I love you. See you in my dreams.',
        'Sleep well, {name}. Tomorrow is another day I get to love you.',
        'Night, {name}. You\'re the last thing on my mind. Always.',
      ],
      MessageTone.poetic: [
        'As the moon takes its place among the stars, {name}, let it carry my love to you — soft as moonlight, endless as the night sky.',
        'Close your eyes, {name}, and let the night wrap you in the same tenderness I wish I could give you right now.',
        'The night is a canvas, {name}, and you are the dream I paint upon it — beautiful, serene, and utterly mine.',
      ],
    },
    MessageMode.anniversary: {
      MessageTone.heartfelt: [
        'Another year with you, {name}, and my heart is fuller than ever. Thank you for every laugh, every tear, and every moment in between.',
        'Happy anniversary, {name}. You turned a simple date into the most meaningful day of my life.',
        '{name}, we\'ve built something beautiful together. Here\'s to us — past, present, and every tomorrow.',
      ],
      MessageTone.playful: [
        'Happy anniversary, {name}! 🎉 Another year of putting up with me — you deserve a trophy. And cake. Definitely cake.',
        '{name}, can you believe we\'ve made it this far? I\'d do it all again. Well, maybe I\'d skip that one argument, but everything else? Perfect.',
        'Cheers to us, {name}! We\'re basically relationship goals. Someone should write a book about us. I volunteer.',
      ],
      MessageTone.direct: [
        'Happy anniversary, {name}. Choosing you is the best decision I ever made. I\'d choose you again in a heartbeat.',
        '{name}, this anniversary means everything to me. You mean everything to me.',
        'Another year, same love. Actually, more love. Happy anniversary, {name}.',
      ],
      MessageTone.poetic: [
        'Our love story, {name}, is written in the language of forever — each chapter more beautiful than the last, each page a testament to what we\'ve built.',
        'Today we celebrate the day two hearts decided to beat as one, {name}. And the melody has only grown more beautiful with time.',
        'Like a river that grows stronger with each passing season, {name}, our love deepens with every anniversary we share.',
      ],
    },
    MessageMode.custom: {
      MessageTone.heartfelt: [
        '{name}, I just wanted to reach out and say something from the heart — you make everything better, and I\'m grateful for you every single day.',
        'Sometimes words aren\'t enough, {name}, but I hope you can feel how much you mean to me through every little thing I do.',
        '{name}, you deserve to know that you\'re thought of, cherished, and loved — right now, and always.',
      ],
      MessageTone.playful: [
        'Random message alert, {name}! 🚨 Reason: I thought about you and couldn\'t NOT send something. You\'re welcome.',
        '{name}, this is your daily reminder that you\'re awesome. Tomorrow\'s reminder will also say you\'re awesome. Seeing a pattern?',
        'Hey {name}! No reason for this message. Just wanted to make you smile. Did it work? 😊',
      ],
      MessageTone.direct: [
        '{name}, I\'m thinking about you. Just wanted you to know.',
        'You\'re important to me, {name}. Never forget that.',
        '{name}, whatever you need, I\'m here. Always.',
      ],
      MessageTone.poetic: [
        'In the quiet moments between the rush of life, {name}, I find myself thinking of you — like a melody that lingers long after the song has ended.',
        'You are the poetry I never knew I needed, {name}. Every moment with you is a verse worth writing.',
        'Like wildflowers that bloom without permission, {name}, my love for you grows — effortless, beautiful, and wild.',
      ],
    },
  };
}

/// Provider for [MessageRepository].
final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  return MessageRepositoryImpl(dio: ref.watch(dioProvider));
});
