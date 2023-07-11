part of 'providers.dart';

class GlobalProvider extends ChangeNotifier {
  late Color _pickerColor;
  Color _currentColor = Colors.pink;
  bool _isLastPageSlider = false;

  String _phrase = "";

  String get getPhrase => _phrase;
  set setPhrase(String value) {
    _phrase = value;
    notifyListeners();
  }

  GlobalProvider() {
    _pickerColor = UserPreferences.getPickerColor == null
        ? Colors.blue
        : Color(UserPreferences.getPickerColor!);
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

  bool get getIsLastPageSlider => _isLastPageSlider;

  set setIsLastPageSlider(bool value) {
    _isLastPageSlider = value;
    notifyListeners();
  }

  Color get pickerColor => _pickerColor;
  Color get currentColor {
    return _currentColor;
  }

  set pickerColor(Color color) {
    _pickerColor = color;
    notifyListeners();
  }

  set currentColor(Color color) {
    _currentColor = color;
    notifyListeners();
  }
}
