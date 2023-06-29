part of 'providers.dart';

class GlobalProvider extends ChangeNotifier {
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

  Color _pickerColor = Colors.blue;
  Color _currentColor = Colors.pink;

  Color get pickerColor => _pickerColor;
  Color get currentColor => _currentColor;
  set pickerColor(Color color) {
    _pickerColor = color;
    notifyListeners();
  }

  set currentColor(Color color) {
    _currentColor = color;
    notifyListeners();
  }
}
