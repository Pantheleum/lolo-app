import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure token storage using platform keychain/keystore.
///
/// Stores:
/// - Firebase auth token
/// - Firebase refresh token
/// - Biometric lock preference
abstract final class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _kAuthToken = 'auth_token';
  static const _kRefreshToken = 'refresh_token';

  static Future<void> saveAuthToken(String token) =>
      _storage.write(key: _kAuthToken, value: token);

  static Future<String?> getAuthToken() =>
      _storage.read(key: _kAuthToken);

  static Future<void> saveRefreshToken(String token) =>
      _storage.write(key: _kRefreshToken, value: token);

  static Future<String?> getRefreshToken() =>
      _storage.read(key: _kRefreshToken);

  static Future<void> clearAll() => _storage.deleteAll();
}
