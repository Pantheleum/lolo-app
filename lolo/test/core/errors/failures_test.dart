import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/core/errors/failures.dart';

void main() {
  group('ServerFailure', () {
    test('contains message', () {
      const failure = ServerFailure(message: 'Server error');
      expect(failure.message, 'Server error');
      expect(failure.code, isNull);
    });

    test('contains message and code', () {
      const failure = ServerFailure(message: 'Error', code: 'ERR_500');
      expect(failure.message, 'Error');
      expect(failure.code, 'ERR_500');
    });
  });

  group('NetworkFailure', () {
    test('contains message', () {
      const failure = NetworkFailure(message: 'No connection');
      expect(failure.message, 'No connection');
      expect(failure.code, isNull);
    });

    test('contains message and code', () {
      const failure = NetworkFailure(message: 'Timeout', code: 'TIMEOUT');
      expect(failure.message, 'Timeout');
      expect(failure.code, 'TIMEOUT');
    });
  });

  group('AuthFailure', () {
    test('contains message', () {
      const failure = AuthFailure(message: 'Unauthorized');
      expect(failure.message, 'Unauthorized');
      expect(failure.code, isNull);
    });

    test('contains message and code', () {
      const failure = AuthFailure(message: 'Token expired', code: 'AUTH_001');
      expect(failure.message, 'Token expired');
      expect(failure.code, 'AUTH_001');
    });
  });

  group('CacheFailure', () {
    test('contains message', () {
      const failure = CacheFailure(message: 'Cache miss');
      expect(failure.message, 'Cache miss');
      expect(failure.code, isNull);
    });

    test('contains message and code', () {
      const failure = CacheFailure(message: 'Expired', code: 'CACHE_EXP');
      expect(failure.message, 'Expired');
      expect(failure.code, 'CACHE_EXP');
    });
  });

  group('ValidationFailure', () {
    test('contains message without field errors', () {
      const failure = ValidationFailure(message: 'Invalid input');
      expect(failure.message, 'Invalid input');
      expect(failure.fieldErrors, isNull);
      expect(failure.code, isNull);
    });

    test('contains field errors', () {
      const failure = ValidationFailure(
        message: 'Invalid input',
        fieldErrors: {'email': 'Invalid email', 'name': 'Required'},
      );
      expect(failure.fieldErrors, isNotNull);
      expect(failure.fieldErrors!['email'], 'Invalid email');
      expect(failure.fieldErrors!['name'], 'Required');
    });

    test('contains message and code', () {
      const failure = ValidationFailure(
        message: 'Bad data',
        code: 'VAL_001',
      );
      expect(failure.code, 'VAL_001');
    });
  });

  group('TierLimitFailure', () {
    test('has required tier', () {
      const failure = TierLimitFailure(
        message: 'Upgrade needed',
        requiredTier: 'premium',
      );
      expect(failure.message, 'Upgrade needed');
      expect(failure.requiredTier, 'premium');
      expect(failure.code, isNull);
    });

    test('has required tier and code', () {
      const failure = TierLimitFailure(
        message: 'Feature locked',
        requiredTier: 'pro',
        code: 'TIER_001',
      );
      expect(failure.requiredTier, 'pro');
      expect(failure.code, 'TIER_001');
    });
  });

  group('Failure hierarchy', () {
    test('all failure types extend Failure', () {
      const failures = <Failure>[
        ServerFailure(message: 'a'),
        CacheFailure(message: 'b'),
        NetworkFailure(message: 'c'),
        AuthFailure(message: 'd'),
        ValidationFailure(message: 'e'),
        TierLimitFailure(message: 'f', requiredTier: 'premium'),
      ];
      expect(failures.length, 6);
      for (final f in failures) {
        expect(f, isA<Failure>());
        expect(f.message, isNotEmpty);
      }
    });
  });
}
