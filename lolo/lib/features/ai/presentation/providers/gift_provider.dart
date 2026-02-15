// FILE: lib/features/ai/presentation/providers/gift_provider.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/features/ai/domain/entities/ai_request.dart';
import 'package:lolo/features/ai/domain/entities/ai_response.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';
import 'package:lolo/features/ai/presentation/providers/ai_providers.dart';
import 'package:lolo/features/ai/presentation/providers/cost_tracker_provider.dart';

part 'gift_provider.freezed.dart';

@freezed
class GiftRecommendationState with _$GiftRecommendationState {
  const factory GiftRecommendationState.idle() = _GiftIdle;
  const factory GiftRecommendationState.loading() = _GiftLoading;
  const factory GiftRecommendationState.success(GiftRecommendationResponse data) = _GiftSuccess;
  const factory GiftRecommendationState.tierLimitReached(int used, int limit) = _GiftTierLimit;
  const factory GiftRecommendationState.error(String message) = _GiftError;
}

class GiftRecommendationNotifier extends Notifier<GiftRecommendationState> {
  @override
  GiftRecommendationState build() => const GiftRecommendationState.idle();

  Future<void> getRecommendations({
    required String profileId,
    required GiftOccasion occasion,
    required double budgetMin,
    required double budgetMax,
    String? occasionDetails,
    String currency = 'USD',
    GiftType giftType = GiftType.any,
    List<String> excludeCategories = const [],
    int count = 5,
  }) async {
    final costTracker = ref.read(costTrackerProvider.notifier);
    final canProceed = await costTracker.checkLimit(AiRequestType.gift);
    if (!canProceed) {
      final usage = costTracker.currentUsage;
      state = GiftRecommendationState.tierLimitReached(
        usage?.used ?? 0,
        usage?.limit ?? 0,
      );
      return;
    }

    state = const GiftRecommendationState.loading();

    final request = GiftRecommendationRequest(
      profileId: profileId,
      occasion: occasion,
      occasionDetails: occasionDetails,
      budgetMin: budgetMin,
      budgetMax: budgetMax,
      currency: currency,
      giftType: giftType,
      excludeCategories: excludeCategories,
      count: count,
    );

    final repo = ref.read(aiRepositoryProvider);
    final result = await repo.getGiftRecommendations(request);

    state = result.fold(
      (f) => GiftRecommendationState.error(f.message),
      (data) {
        costTracker.recordUsage(AiRequestType.gift, data.usage);
        return GiftRecommendationState.success(data);
      },
    );
  }

  Future<void> submitFeedback(String giftId, String outcome, {String? comment}) async {
    final repo = ref.read(aiRepositoryProvider);
    await repo.submitGiftFeedback(giftId, outcome, comment: comment);
  }

  void reset() => state = const GiftRecommendationState.idle();
}

final giftRecommendationNotifierProvider =
    NotifierProvider<GiftRecommendationNotifier, GiftRecommendationState>(
  GiftRecommendationNotifier.new,
);
