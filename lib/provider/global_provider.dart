part of 'providers.dart';

class GlobalProvider extends ChangeNotifier {
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
