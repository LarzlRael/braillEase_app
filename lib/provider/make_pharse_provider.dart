// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'providers.dart';

final makePhraseNotifier =
    StateNotifierProvider<MakePhraseNotifier, MakePhraseState>((ref) {
  return MakePhraseNotifier();
});

class MakePhraseNotifier extends StateNotifier<MakePhraseState> {
  MakePhraseNotifier()
      : super(MakePhraseState(
          wordToShow: '',
          matchingCharacters: [],
        ));
  final defaultWord = [false, false, false, false, false, false];

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

class MakePhraseState {
  final String wordToShow;
  final List<String> matchingCharacters;

  /* final Color pickerTextColor; */

  MakePhraseState({
    required this.wordToShow,
    required this.matchingCharacters,
  });

  MakePhraseState copyWith({
    String? wordToShow,
    List<String>? matchingCharacters,
  }) {
    return MakePhraseState(
      wordToShow: wordToShow ?? this.wordToShow,
      matchingCharacters: matchingCharacters ?? this.matchingCharacters,
    );
  }
}
