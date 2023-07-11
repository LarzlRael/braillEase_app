part of 'providers.dart';

class BrailleProvider with ChangeNotifier {
  List<bool> _word = [false, false, false, false, false, false];

  List<bool> get getWord => _word;
  set setWord(List<bool> word) {
    _word = word;
    notifyListeners();
  }

  void setWordIndex(int index, bool value) {
    this._word[index] = value;
    notifyListeners();
  }

  void clearWord() {
    this._word = [false, false, false, false, false, false];
    notifyListeners();
  }

  void fillWord() {
    this._word = [true, true, true, true, true, true];
    notifyListeners();
  }

  late PagesSizes _selectedPagesSizes;
  late String braileConverted;
  Color pickerTextColor = Colors.black;
  String _normalText = '';

  Color get getPickerTextColor => pickerTextColor;
  set setPickerTextColor(Color color) {
    pickerTextColor = color;
    notifyListeners();
  }

  set setBraileConverted(String braile) {
    braileConverted = braile;
    notifyListeners();
  }

  String get getBraileConverted => braileConverted;
  set setSelectedPagesSizes(PagesSizes pagesSizes) {
    _selectedPagesSizes = pagesSizes;
    notifyListeners();
  }

  PagesSizes get selectedPagesSizes => _selectedPagesSizes;

  set setNormalText(String normalText) {
    _normalText = normalText;
    notifyListeners();
  }

  String get getNormalText => _normalText;
}
