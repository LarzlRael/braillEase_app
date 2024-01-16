part of 'providers.dart';

final globalProvider =
    StateNotifierProvider<GlobalProvider, GlobalState>((ref) {
  return GlobalProvider();
});

class GlobalProvider extends StateNotifier<GlobalState> {
  final _keyValueStorageServiceImpl = KeyValueStorageServiceImpl();
  GlobalProvider()
      : super(GlobalState(
          pickerColor: Colors.blue,
          currentColor: Colors.blue,
          phrase: '',
          isDarkModeEnabled: UserPreferences.isDarkModeEnabled,
        )) {
    init();
  }

  void init() async {
    final color = await _keyValueStorageServiceImpl.getValue<int>(
      CURRENT_COLOR_KEY,
    );
    final isDarkModeEnabled = await _keyValueStorageServiceImpl.getValue<bool>(
      IS_DARK_MODE_ENABLED_KEY,
    );
    state = state.copyWith(
      currentColor: Color(color ?? Colors.blue.value),
      isDarkModeEnabled: isDarkModeEnabled ?? false,
    );
  }

  void setPhrase(String value) {
    state = state.copyWith(phrase: value);
  }

  Future<void> toggleTheme() async {
    state = state.copyWith(
      isDarkModeEnabled: !state.isDarkModeEnabled,
    );
    _keyValueStorageServiceImpl.setKeyValue<bool>(
      IS_DARK_MODE_ENABLED_KEY,
      state.isDarkModeEnabled,
    );
  }

  void showSnackBar(
    BuildContext context,
    String message, {
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  void setPickerColor(Color color) {
    state = state.copyWith(pickerColor: color);
  }

  Future<void> currentColor(Color color) async {
    state = state.copyWith(currentColor: color);
    await _keyValueStorageServiceImpl.setKeyValue<int>(
      CURRENT_COLOR_KEY,
      color.value,
    );
  }
}

class GlobalState {
  final Color pickerColor;
  final Color currentColor;

  final String phrase;
  final bool isDarkModeEnabled;

  GlobalState({
    required this.pickerColor,
    required this.currentColor,
    required this.phrase,
    required this.isDarkModeEnabled,
  });

  GlobalState copyWith({
    Color? pickerColor,
    Color? currentColor,
    bool? isLastPageSlider,
    String? phrase,
    bool? isDarkModeEnabled,
  }) =>
      GlobalState(
        pickerColor: pickerColor ?? this.pickerColor,
        currentColor: currentColor ?? this.currentColor,
        phrase: phrase ?? this.phrase,
        isDarkModeEnabled: isDarkModeEnabled ?? this.isDarkModeEnabled,
      );
}
