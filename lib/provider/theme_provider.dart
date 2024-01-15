// ignore_for_file: public_member_api_docs, sort_constructors_first
part of './providers.dart';

/* class ThemeProviderNotifier extends ChangeNotifier {
  /* STATE = estado => new AppTheme */
  AppTheme _appTheme = AppTheme(
    isDarkMode: UserPreferences.isDarkModeEnabled,
  ); // Estado interno

  AppTheme get appTheme => _appTheme; // Acceso al estado
  bool get isDarkModeEnabled => _appTheme
      .isDarkMode; // Propiedad para verificar si el tema oscuro está habilitado o no

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
    notifyListeners();
  }

  void changeToDarkTheme() {
    _appTheme = _appTheme.copyWith(
      isDarkMode: false,
    );
    notifyListeners();
  }
} */

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier()
      : super(SettingsState(
          isDarkModeEnabled: UserPreferences.isDarkModeEnabled,
        ));

  void toggleTheme() {
    state = state.copyWith(
      isDarkModeEnabled: !state.isDarkModeEnabled,
    );
    UserPreferences.isDarkModeEnabled = state.isDarkModeEnabled;
  }
}

class AppTheme {
  final bool isDarkmode;

  AppTheme({required this.isDarkmode});

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.blue,
        ),
      );
}

class SettingsState {
  final bool isDarkModeEnabled;

  SettingsState({required this.isDarkModeEnabled});

  SettingsState copyWith({
    bool? isDarkModeEnabled,
  }) {
    return SettingsState(
      isDarkModeEnabled: isDarkModeEnabled ?? this.isDarkModeEnabled,
    );
  }
}
