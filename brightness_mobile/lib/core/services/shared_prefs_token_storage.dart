import 'package:shared_preferences/shared_preferences.dart';
import 'token_storage.dart';

class SharedPrefsTokenStorage implements TokenStorage {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  final SharedPreferences _prefs;

  SharedPrefsTokenStorage(this._prefs);

  static Future<SharedPrefsTokenStorage> create() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPrefsTokenStorage(prefs);
  }

  @override
  Future<String?> getAccessToken() async {
    return _prefs.getString(_accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return _prefs.getString(_refreshTokenKey);
  }

  @override
  Future<void> setAccessToken(String? token) async {
    if (token == null) {
      await _prefs.remove(_accessTokenKey);
    } else {
      await _prefs.setString(_accessTokenKey, token);
    }
  }

  @override
  Future<void> setRefreshToken(String? token) async {
    if (token == null) {
      await _prefs.remove(_refreshTokenKey);
    } else {
      await _prefs.setString(_refreshTokenKey, token);
    }
  }
}
