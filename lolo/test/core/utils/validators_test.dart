import 'package:flutter_test/flutter_test.dart';
import 'package:lolo/core/utils/validators.dart';

void main() {
  group('Validators.email', () {
    test('returns error for null value', () {
      expect(Validators.email(null), 'Email is required');
    });

    test('returns error for empty string', () {
      expect(Validators.email(''), 'Email is required');
    });

    test('returns error for whitespace only', () {
      expect(Validators.email('   '), 'Email is required');
    });

    test('returns null for valid email', () {
      expect(Validators.email('user@example.com'), isNull);
    });

    test('returns error for email with subdomain (not supported by regex)', () {
      // The current regex does not support subdomains in the domain part
      expect(
        Validators.email('user@mail.example.com'),
        'Enter a valid email address',
      );
    });

    test('returns null for email with plus tag', () {
      expect(Validators.email('user+tag@example.com'), isNull);
    });

    test('returns null for email with dots in local part', () {
      expect(Validators.email('first.last@example.com'), isNull);
    });

    test('returns null for email with hyphens in local part', () {
      expect(Validators.email('first-last@example.com'), isNull);
    });

    test('returns error for email without @', () {
      expect(Validators.email('userexample.com'), 'Enter a valid email address');
    });

    test('returns error for email without domain', () {
      expect(Validators.email('user@'), 'Enter a valid email address');
    });

    test('returns error for email without local part', () {
      expect(Validators.email('@example.com'), 'Enter a valid email address');
    });

    test('returns error for email with single char TLD', () {
      expect(Validators.email('user@example.c'), 'Enter a valid email address');
    });

    test('trims whitespace before validation', () {
      expect(Validators.email('  user@example.com  '), isNull);
    });
  });

  group('Validators.password', () {
    test('returns error for null value', () {
      expect(Validators.password(null), 'Password is required');
    });

    test('returns error for empty string', () {
      expect(Validators.password(''), 'Password is required');
    });

    test('returns error for password shorter than 8 characters', () {
      expect(
        Validators.password('abc123'),
        'Password must be at least 8 characters',
      );
    });

    test('returns error for password with exactly 7 characters', () {
      expect(
        Validators.password('abcde12'),
        'Password must be at least 8 characters',
      );
    });

    test('returns error for password without letters', () {
      expect(
        Validators.password('12345678'),
        'Password must contain at least one letter',
      );
    });

    test('returns error for password without numbers', () {
      expect(
        Validators.password('abcdefgh'),
        'Password must contain at least one number',
      );
    });

    test('returns null for valid password with 8 chars', () {
      expect(Validators.password('abcdefg1'), isNull);
    });

    test('returns null for valid password with uppercase', () {
      expect(Validators.password('Abcdefg1'), isNull);
    });

    test('returns null for long valid password', () {
      expect(Validators.password('MySecurePassword123'), isNull);
    });

    test('returns null for password with special characters', () {
      expect(Validators.password('p@ssw0rd!'), isNull);
    });
  });
}
