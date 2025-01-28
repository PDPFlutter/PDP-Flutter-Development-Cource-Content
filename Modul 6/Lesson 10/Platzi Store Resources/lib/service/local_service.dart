import 'package:shared_preferences/shared_preferences.dart';
import '../models/token/token.dart';

enum StorageKey {
  accessToken,
  refreshToken,
}

sealed class TokenService {
  static Future<void> saveAccessToken(String token) => LocalService.store(StorageKey.accessToken, token);
  static Future<void> saveRefreshToken(String token) => LocalService.store(StorageKey.refreshToken, token);

  static Future<String?> get accessToken => LocalService.read(StorageKey.accessToken);
  static Future<String?> get refreshToken => LocalService.read(StorageKey.refreshToken);

  static Future<void> deleteTokens() async {
    await Future.wait([
      LocalService.remove(StorageKey.accessToken),
      LocalService.remove(StorageKey.refreshToken),
    ]);
  }

  static Future<void> saveTokens({required Token token}) async {
    await Future.wait([
      LocalService.store(StorageKey.accessToken, token.accessToken),
      LocalService.store(StorageKey.refreshToken, token.refreshToken),
    ]);
  }
}

sealed class LocalService {
  static Future<void> store(StorageKey key, String data) async {
    final prefs = SharedPreferencesAsync();
    await prefs.setString(key.name, data);
  }

  static Future<String?> read(StorageKey key) async {
    final prefs = SharedPreferencesAsync();
    final data = await prefs.getString(key.name);
    return data;
  }

  static Future<void> remove(StorageKey key) async {
    final prefs = SharedPreferencesAsync();
    await prefs.remove(key.name);
  }
}
