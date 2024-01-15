part of 'providers.dart';

final globalProvider =
    StateNotifierProvider<GlobalProvider, GlobalState>((ref) {
  return GlobalProvider();
});

class GlobalProvider extends StateNotifier<GlobalState> {
  GlobalProvider()
      : super(GlobalState(
          pickerColor: Colors.blue,
          currentColor: Colors.blue,
          isLastPageSlider: false,
          phrase: '',
        ));

  void setPhrase(String value) {
    state = state.copyWith(phrase: value);
  }

  /* GlobalProvider() {
    _pickerColor = UserPreferences.getPickerColor == null
        ? Colors.blue
        : Color(UserPreferences.getPickerColor!);
  } */
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

  void setIsLastPageSlider(bool value) {
    state = state.copyWith(isLastPageSlider: value);
  }

  void setPickerColor(Color color) {
    state = state.copyWith(pickerColor: color);
  }

  void currentColor(Color color) {
    state = state.copyWith(currentColor: color);
  }
}

class GlobalState {
  final Color pickerColor;
  final Color currentColor;
  final bool isLastPageSlider;
  final String phrase;

  GlobalState({
    required this.pickerColor,
    required this.currentColor,
    required this.isLastPageSlider,
    required this.phrase,
  });

  GlobalState copyWith({
    Color? pickerColor,
    Color? currentColor,
    bool? isLastPageSlider,
    String? phrase,
  }) =>
      GlobalState(
        pickerColor: pickerColor ?? this.pickerColor,
        currentColor: currentColor ?? this.currentColor,
        isLastPageSlider: isLastPageSlider ?? this.isLastPageSlider,
        phrase: phrase ?? this.phrase,
      );
}
