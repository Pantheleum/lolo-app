import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/core/network/network_exceptions.dart';

void main() {
  group('NoConnectionException', () {
    test('has correct userMessage', () {
      const exception = NoConnectionException();
      expect(
        exception.userMessage,
        'No internet connection. Check your network.',
      );
    });

    test('can be created via factory constructor', () {
      const exception = NetworkException.noConnection();
      expect(exception, isA<NoConnectionException>());
    });
  });

  group('TimeoutException', () {
    test('has correct userMessage', () {
      const exception = TimeoutException();
      expect(exception.userMessage, 'Request timed out. Please try again.');
    });

    test('can be created via factory constructor', () {
      const exception = NetworkException.timeout();
      expect(exception, isA<TimeoutException>());
    });
  });

  group('UnauthorizedException', () {
    test('has correct userMessage', () {
      const exception = UnauthorizedException();
      expect(
        exception.userMessage,
        'Session expired. Please log in again.',
      );
    });

    test('can be created via factory constructor', () {
      const exception = NetworkException.unauthorized();
      expect(exception, isA<UnauthorizedException>());
    });
  });

  group('ForbiddenException', () {
    test('has default userMessage when no message provided', () {
      const exception = ForbiddenException(code: 'FORBIDDEN');
      expect(exception.userMessage, 'Access denied.');
      expect(exception.code, 'FORBIDDEN');
    });

    test('has custom userMessage when message provided', () {
      const exception = ForbiddenException(
        code: 'TIER_LIMIT',
        message: 'Premium only feature',
      );
      expect(exception.userMessage, 'Premium only feature');
    });

    test('can be created via factory constructor', () {
      const exception = NetworkException.forbidden(code: 'TEST');
      expect(exception, isA<ForbiddenException>());
    });
  });

  group('BadRequestException', () {
    test('has default userMessage when no message provided', () {
      const exception = BadRequestException();
      expect(exception.userMessage, 'Invalid request.');
      expect(exception.code, isNull);
    });

    test('has custom userMessage when message provided', () {
      const exception = BadRequestException(
        message: 'Missing field',
        code: 'BAD_REQ',
      );
      expect(exception.userMessage, 'Missing field');
      expect(exception.code, 'BAD_REQ');
    });

    test('can be created via factory constructor', () {
      const exception = NetworkException.badRequest();
      expect(exception, isA<BadRequestException>());
    });
  });

  group('NotFoundException', () {
    test('has default userMessage when no message provided', () {
      const exception = NotFoundException();
      expect(exception.userMessage, 'Resource not found.');
    });

    test('has custom userMessage when message provided', () {
      const exception = NotFoundException(message: 'Profile not found');
      expect(exception.userMessage, 'Profile not found');
    });

    test('can be created via factory constructor', () {
      const exception = NetworkException.notFound();
      expect(exception, isA<NotFoundException>());
    });
  });

  group('ConflictException', () {
    test('has default userMessage when no message provided', () {
      const exception = ConflictException();
      expect(exception.userMessage, 'Conflict detected.');
      expect(exception.code, isNull);
    });

    test('has custom userMessage when message provided', () {
      const exception = ConflictException(
        message: 'Duplicate entry',
        code: 'CONFLICT',
      );
      expect(exception.userMessage, 'Duplicate entry');
      expect(exception.code, 'CONFLICT');
    });

    test('can be created via factory constructor', () {
      const exception = NetworkException.conflict();
      expect(exception, isA<ConflictException>());
    });
  });

  group('RateLimitedException', () {
    test('has correct userMessage', () {
      const exception = RateLimitedException();
      expect(
        exception.userMessage,
        'Too many requests. Please wait a moment.',
      );
    });

    test('can be created via factory constructor', () {
      const exception = NetworkException.rateLimited();
      expect(exception, isA<RateLimitedException>());
    });
  });

  group('ServerErrorException', () {
    test('has default userMessage when no message provided', () {
      const exception = ServerErrorException();
      expect(
        exception.userMessage,
        'Server error. We are working on it.',
      );
    });

    test('has custom userMessage when message provided', () {
      const exception = ServerErrorException(message: 'Internal failure');
      expect(exception.userMessage, 'Internal failure');
    });

    test('can be created via factory constructor', () {
      const exception = NetworkException.serverError();
      expect(exception, isA<ServerErrorException>());
    });
  });

  group('UnknownNetworkException', () {
    test('has default userMessage when no message provided', () {
      const exception = UnknownNetworkException();
      expect(exception.userMessage, 'Something went wrong.');
    });

    test('has custom userMessage when message provided', () {
      const exception = UnknownNetworkException(message: 'Unexpected error');
      expect(exception.userMessage, 'Unexpected error');
    });

    test('can be created via factory constructor', () {
      const exception = NetworkException.unknown();
      expect(exception, isA<UnknownNetworkException>());
    });
  });

  group('NetworkException sealed class', () {
    test('all subtypes implement NetworkException', () {
      final exceptions = <NetworkException>[
        const NoConnectionException(),
        const TimeoutException(),
        const UnauthorizedException(),
        const ForbiddenException(code: 'TEST'),
        const BadRequestException(),
        const NotFoundException(),
        const ConflictException(),
        const RateLimitedException(),
        const ServerErrorException(),
        const UnknownNetworkException(),
      ];
      for (final e in exceptions) {
        expect(e, isA<NetworkException>());
        expect(e.userMessage, isNotNull);
        expect(e.userMessage, isNotEmpty);
      }
    });

    test('pattern matching works via switch expression', () {
      const NetworkException exception = NoConnectionException();
      final message = switch (exception) {
        NoConnectionException() => 'no_connection',
        TimeoutException() => 'timeout',
        UnauthorizedException() => 'unauthorized',
        ForbiddenException() => 'forbidden',
        BadRequestException() => 'bad_request',
        NotFoundException() => 'not_found',
        ConflictException() => 'conflict',
        RateLimitedException() => 'rate_limited',
        ServerErrorException() => 'server_error',
        UnknownNetworkException() => 'unknown',
      };
      expect(message, 'no_connection');
    });
  });
}
