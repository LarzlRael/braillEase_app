// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'providers.dart';

final brailleProvider =
    StateNotifierProvider<BrailleNotifier, BrailleState>((ref) {
  return BrailleNotifier();
});

/* class BraiilerNotifier extends StateNotifier<BrailleState> {
  BraiilerNotifier() : super();

  void increment() {
    state = state.copyWith(count: state.count + 1);
  }
} */

class BrailleNotifier extends StateNotifier<BrailleState> {
  BrailleNotifier()
      : super(BrailleState(
          pagesSizes: PagesSizes(
              sizeName: 'Letter', size: '20', pageFormat: PdfPageFormat.letter),
          word: [false, false, false, false, false, false],
          normalText: '',
          braileConverted: '',
          pickerTextColor: Colors.black,
        ));
  final defaultWord = [false, false, false, false, false, false];

  void setWord(List<bool> word) {
    state = state.copyWith(word: word);
  }

  void setWordIndex(int index, bool value) {
    state = state.copyWith(
      word: List.of(state.word)..[index] = value,
    );
  }

  void clearWord() {
    state = state.copyWith(word: [false, false, false, false, false, false]);
  }

  void fillWord() {
    state = state.copyWith(word: [true, true, true, true, true, true]);
  }

  void setPickerTextColor(Color color) {
    state = state.copyWith(pickerTextColor: color);
  }

  void setBraileConverted(String braile) {
    state = state.copyWith(braileConverted: braile);
  }

  void setSelectedPagesSizes(PagesSizes pagesSizes) {
    state = state.copyWith(pagesSizes: pagesSizes);
  }

  void setNormalText(String normalText) {
    state = state.copyWith(normalText: normalText);
  }
}

class BrailleState {
  final List<bool> word;
  final PagesSizes pagesSizes;
  final String braileConverted;
  final String normalText;

  final Color pickerTextColor;

  BrailleState({
    required this.word,
    required this.normalText,
    required this.pagesSizes,
    required this.braileConverted,
    required this.pickerTextColor,
  });

  BrailleState copyWith({
    List<bool>? word,
    PagesSizes? pagesSizes,
    String? braileConverted,
    Color? pickerTextColor,
    String? normalText,
  }) {
    return BrailleState(
      word: word ?? this.word,
      pagesSizes: pagesSizes ?? this.pagesSizes,
      braileConverted: braileConverted ?? this.braileConverted,
      pickerTextColor: pickerTextColor ?? this.pickerTextColor,
      normalText: normalText ?? this.normalText,
    );
  }
}
