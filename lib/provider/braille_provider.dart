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
            sizeName: 'Letter',
            size: '20',
            pageFormat: PdfPageFormat.letter,
          ),
          word: [false, false, false, false, false, false],
          normalText: '',
          braileConverted: '',
          wordToShow: '',
          matchingCharacters: [],
        ));
  final defaultWord = [false, false, false, false, false, false];

  void setWord(List<bool> word) {
    state = state.copyWith(word: word);
  }

  void setWordIndex(
      int index, bool value, Function(List<bool> updatedWord) cb) {
    state = state.copyWith(
      word: List.of(state.word)..[index] = value,
    );
    cb(state.word);
  }

  void clearWord() {
    state = state.copyWith(
      word: [false, false, false, false, false, false],
      braileConverted: '',
      normalText: '',
    );
  }

  void fillWord() {
    state = state.copyWith(word: [true, true, true, true, true, true]);
  }

  void setPickerTextColor(Color color) {
    state = state.copyWith(pickerTextColor: color);
  }

  void setSelectedPagesSizes(PagesSizes pagesSizes) {
    state = state.copyWith(pagesSizes: pagesSizes);
  }

  void setNormalText(String normalText) {
    state = state.copyWith(
      normalText: normalText,
      braileConverted: convertToBraillex(normalText),
    );
  }

  void selectedAndPop(String x) {
    state = state.copyWith(
      wordToShow: '',
      matchingCharacters: [],
    );

    /* brailleProviderN.setNormalText(brailleProviderS.normalText + x.toString());
    brailleProviderN.clearWord();
    textFormController.text = textFormController.text + x.toString();
    setState(() {
      matchingCharacters.clear();
    }); */
  }

  void handleWordChanged(List<bool> word) {
    print('word: $word');
    List<String> matchingCharacters = [];
    brailleMap.forEach((character, array) {
      if (listEquals(array, word)) {
        matchingCharacters.add(character);
        state = state.copyWith(
          matchingCharacters: matchingCharacters,
        );
      }
    });

    if (state.matchingCharacters.isNotEmpty) {
      state = state.copyWith(
        wordToShow: state.matchingCharacters[0],
      );
    } /* else {
      state = state.copyWith(
        wordToShow: '',
        matchingCharacters: [],
      );
    } */
    inspect(state);
  }
}

class BrailleState {
  final List<bool> word;
  final PagesSizes pagesSizes;
  final String braileConverted;
  final String normalText;
  final String wordToShow;
  final List<String> matchingCharacters;

  BrailleState({
    required this.word,
    required this.normalText,
    required this.pagesSizes,
    required this.braileConverted,
    required this.wordToShow,
    required this.matchingCharacters,
  });

  BrailleState copyWith({
    List<bool>? word,
    PagesSizes? pagesSizes,
    String? braileConverted,
    Color? pickerTextColor,
    String? normalText,
    String? wordToShow,
    List<String>? matchingCharacters,
  }) {
    return BrailleState(
      word: word ?? this.word,
      pagesSizes: pagesSizes ?? this.pagesSizes,
      braileConverted: braileConverted ?? this.braileConverted,
      normalText: normalText ?? this.normalText,
      wordToShow: wordToShow ?? this.wordToShow,
      matchingCharacters: matchingCharacters ?? this.matchingCharacters,
    );
  }
}
