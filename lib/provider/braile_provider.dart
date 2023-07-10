part of 'providers.dart';

class BraileProvider with ChangeNotifier {
  late PagesSizes _selectedPagesSizes;
  late String braileConverted;
  Color pickerTextColor = Colors.black;
  String _normalText = '';
  List<bool> word = [false, false, false, false, false, false];

  List<bool> get getWord => word;
  set setWord(List<bool> word) {
    this.word = word;
    notifyListeners();
  }

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
