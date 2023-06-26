part of 'utils.dart';

final brailleMap = {
  'a': [true, false, false, false, false, false],
  'b': [true, false, true, false, false, false],
  'c': [true, true, false, false, false, false],
  'd': [true, true, false, true, false, false],
  'e': [true, false, false, true, false, false],
  'f': [true, true, true, false, false, false],
  'g': [true, true, true, true, false, false],
  'h': [true, false, true, true, false, false],
  'i': [false, true, false, true, false, false],
  'j': [false, true, false, true, true, false],
  'k': [true, false, false, false, false, true],
  'l': [true, false, true, false, false, true],
  'm': [true, true, false, false, false, true],
  'n': [true, true, false, true, false, true],
  'ñ': [true, true, true, false, false, true],
  'o': [true, false, false, true, false, true],
  'p': [true, true, true, true, false, true],
  'q': [true, true, true, true, true, true],
  'r': [true, false, true, true, true, true],
  's': [false, true, true, true, false, true],
  't': [false, true, true, true, true, true],
  'u': [true, false, false, false, true, true],
  'v': [true, false, true, false, true, true],
  'w': [false, true, true, true, false, false],
  'x': [true, true, false, false, true, true],
  'y': [true, true, false, true, true, true],
  'z': [true, false, false, true, true, true],
  ' ': [false, false, false, false, false, false], // Espacio en blanco
};
List<List<bool>> getLetterConverted(String word) {
  final brailleWord = <List<bool>>[];

  for (var i = 0; i < word.length; i++) {
    final letter = word[i].toLowerCase();
    final brailleLetter = brailleMap[letter];

    if (brailleLetter != null) {
      brailleWord.add(brailleLetter);
    }
  }

  return brailleWord;
}
