import 'package:get_storage/get_storage.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  late GetStorage _storage;

  // Storage Keys
  static const String keyIsFirstLaunch = 'is_first_launch';
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserId = 'user_id';
  static const String keyUserData = 'user_data';
  static const String keyBiometricEnabled = 'biometric_enabled';
  static const String keyPasscode = 'passcode';
  static const String keySelectedAccountId = 'selected_account_id';
  static const String keyThemeMode = 'theme_mode';

  Future<void> init() async {
    await GetStorage.init();
    _storage = GetStorage();
  }

  // Generic methods
  Future<void> write(String key, dynamic value) async {
    await _storage.write(key, value);
  }

  T? read<T>(String key) {
    return _storage.read<T>(key);
  }

  Future<void> remove(String key) async {
    await _storage.remove(key);
  }

  Future<void> clear() async {
    await _storage.erase();
  }

  // Specific methods
  bool get isFirstLaunch => read<bool>(keyIsFirstLaunch) ?? true;
  Future<void> setFirstLaunch(bool value) => write(keyIsFirstLaunch, value);

  bool get isLoggedIn => read<bool>(keyIsLoggedIn) ?? false;
  Future<void> setLoggedIn(bool value) => write(keyIsLoggedIn, value);

  String? get userId => read<String>(keyUserId);
  Future<void> setUserId(String value) => write(keyUserId, value);

  Map<String, dynamic>? get userData => read<Map<String, dynamic>>(keyUserData);
  Future<void> setUserData(Map<String, dynamic> value) =>
      write(keyUserData, value);

  bool get biometricEnabled => read<bool>(keyBiometricEnabled) ?? false;
  Future<void> setBiometricEnabled(bool value) =>
      write(keyBiometricEnabled, value);

  String? get passcode => read<String>(keyPasscode);
  Future<void> setPasscode(String value) => write(keyPasscode, value);

  String? get selectedAccountId => read<String>(keySelectedAccountId);
  Future<void> setSelectedAccountId(String value) =>
      write(keySelectedAccountId, value);

  String get themeMode => read<String>(keyThemeMode) ?? 'dark';
  Future<void> setThemeMode(String value) => write(keyThemeMode, value);

  Future<void> logout() async {
    await setLoggedIn(false);
    await remove(keyUserId);
    await remove(keyUserData);
  }
}
