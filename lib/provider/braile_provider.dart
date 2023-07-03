part of 'providers.dart';

class BraileProvider with ChangeNotifier {
  late PagesSizes _selectedPagesSizes;
  late String braileConverted;

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
}
