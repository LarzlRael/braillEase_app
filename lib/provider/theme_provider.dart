part of './providers.dart';

class ThemeProviderNotifier extends ChangeNotifier {
  /* STATE = estado => new AppTheme */
  AppTheme _appTheme = AppTheme(
    isDarkMode: UserPreferences.isDarkModeEnabled,
  ); // Estado interno

  AppTheme get appTheme => _appTheme; // Acceso al estado
  bool get isDarkModeEnabled => _appTheme
      .isDarkMode; // Propiedad para verificar si el tema oscuro está habilitado o no

  bool _isLastPageSlider = false;
  bool get isLastPageSlider => _isLastPageSlider;
  set isLastPageSlider(bool value) {
    _isLastPageSlider = value;
    notifyListeners();
  }

  void toggleTheme() {
    _appTheme = _appTheme.copyWith(
      isDarkMode: !_appTheme.isDarkMode,
    );
    notifyListeners(); // Notificar a los oyentes del cambio de estado
  }

  void changeToLightTheme() {
    _appTheme = _appTheme.copyWith(
      isDarkMode: false,
    );
    notifyListeners(); // Notificar a los oyentes del cambio de estado
  }

  void changeToDarkTheme() {
    _appTheme = _appTheme.copyWith(
      isDarkMode: false,
    );
    notifyListeners(); // Notificar a los oyentes del cambio de estado
  }
}
