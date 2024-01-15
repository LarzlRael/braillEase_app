part of 'utils.dart';

class UserPreferences {
  //no one this properties it is used
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isFirstTime => _prefs.getBool('isFirstTime') ?? true;

  static set isFirstTime(bool value) {
    _prefs.setBool('isFirstTime', value);
  }

  /* Theme status */
  static bool get isDarkModeEnabled => _prefs.getBool('isDarkTheme') ?? false;
  static set isDarkModeEnabled(bool value) =>
      _prefs.setBool('isDarkTheme', value);

  static int? get getPickerColor =>
      _prefs.getInt('pickerColor') ?? Colors.blue.value;
  static set setPickerColor(int colorValue) =>
      _prefs.setInt('pickerColor', colorValue);

  static int get getCountIntersitialAd =>
      _prefs.getInt('countIntersitialAd') ?? 0;

  static set setCountInterstialAd(int value) {
    _prefs.setInt('countIntersitialAd', value);
  }

  static String get getFCMToken => _prefs.getString('FCMToken') ?? '';

  static set setFCMToken(String token) {
    _prefs.setString('FCMToken', token);
  }
}
