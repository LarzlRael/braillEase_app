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
  '0': [false, true, true, false, false, false],
  '1': [true, false, false, false, false, false],
  '2': [true, false, true, false, false, false],
  '3': [true, true, false, false, false, false],
  '4': [true, true, false, true, false, false],
  '5': [true, false, false, true, false, false],
  '6': [true, true, true, false, false, false],
  '7': [true, true, true, true, false, false],
  '8': [true, false, true, true, false, false],
  '9': [false, true, false, true, false, false],
  '.': [false, false, true, true, true, true], // Punto
  ',': [false, true, false, false, false, false], // Coma
  ';': [false, true, true, false, false, true], // Punto y coma
  ':': [false, true, false, true, false, true], // Dos puntos
  '?': [false, true, true, false, true, false], // Signo de interrogación
  '!': [false, true, true, true, true, false], // Signo de exclamación
  "'": [false, false, false, true, false, false], // Comilla simple
  '"': [false, false, false, true, false, true], // Comillas dobles
  '(': [false, true, false, true, true, false], // Paréntesis izquierdo
  ')': [false, true, true, false, true, true], // Paréntesis derecho
  '[': [false, true, true, true, true, true], // Corchete izquierdo
  ']': [false, true, true, true, true, true], // Corchete derecho
  '{': [false, true, true, true, true, true], // Llave izquierda
  '}': [false, true, true, true, true, true], // Llave derecha
  '-': [false, false, false, false, true, true], // Guión
  '/': [false, false, true, true, false, true], // Barra diagonal
  '\\': [false, false, true, true, true, false], // Barra diagonal inversa
  '+': [false, false, true, true, false, true], // Signo más
  '=': [false, false, true, true, true, true], // Signo igual
  '<': [false, true, false, false, true, true], // Menor que
  '>': [false, true, true, false, true, true], // Mayor que
  '%': [false, true, true, false, true, true], // Porcentaje
  '#': [false, true, false, false, true, false], // Numeral
  '@': [false, true, true, true, false, true], // Arroba
  '\$': [false, true, true, false, false, true], // Signo de dólar
  '€': [false, false, true, true, true, true], // Euro
  '£': [false, true, false, true, true, true], // Libra esterlina
  '¥': [false, true, false, false, true, true], // Yen
  '¢': [false, false, false, true, true, true], // Centavo
  '®': [false, true, true, false, true, false], // Registrado
  '©': [false, true, true, false, true, true], // Copyright
  '™': [false, true, true, true, false, true], // Marca comercial
  '°': [false, true, false, false, false, true], // Grado
  '§': [false, true, false, true, false, false], // Sección
  '&': [false, true, true, true, false, false], // Ampersand
  '*': [false, true, true, true, false, true], // Asterisco
  '~': [false, true, false, false, true, false], // Tilde
};
final braileNumericFormat = {
  'a': 1,
  'b': 12,
  'c': 14,
  'd': 145,
  'e': 15,
  'f': 124,
  'g': 1245,
  'h': 125,
  'i': 24,
  'j': 245,
  'k': 13,
  'l': 123,
  'm': 134,
  'n': 1345,
  'ñ': 1234,
  'o': 135,
  'p': 1235,
  'q': 12345,
  'r': 1235,
  's': 2345,
  't': 345,
  'u': 136,
  'v': 1236,
  'w': 2456,
  'x': 1346,
  'y': 13456,
  'z': 1356,
};

Map<String, String> brailleSimbolMap = {
  'a': '⠁',
  'b': '⠃',
  'c': '⠉',
  'd': '⠙',
  'e': '⠑',
  'f': '⠋',
  'g': '⠛',
  'h': '⠓',
  'i': '⠊',
  'j': '⠚',
  'k': '⠅',
  'l': '⠇',
  'm': '⠍',
  'n': '⠝',
  'o': '⠕',
  'p': '⠏',
  'q': '⠟',
  'r': '⠗',
  's': '⠎',
  't': '⠞',
  'u': '⠥',
  'v': '⠧',
  'w': '⠺',
  'x': '⠭',
  'y': '⠽',
  'z': '⠵',
  ' ': ' ',
};
String convertToBraillex(String word) {
  String brailleWord = '';

  for (var i = 0; i < word.length; i++) {
    final letter = word[i].toLowerCase();
    final brailleLetter = brailleSimbolMap[letter];

    if (brailleLetter != null) {
      brailleWord += brailleLetter;
    }
  }
  return brailleWord;
  /* return word; */
}

String validateAndCleanWord(String word) {
  final regex = RegExp(r'[^\w\s]');
  final cleanedWord = word.replaceAll(regex, '');

  return cleanedWord;
}

String cleanWord(String word) {
  final cleanedWord = validateAndCleanWord(word);

  final brailleWord = cleanedWord.split('').map((char) {
    return brailleMap.containsKey(char.toLowerCase()) ? char : '';
  }).join('');
  return brailleWord;
}

List<List<bool>> getLetterConverted(String word) {
/*   String cleanedWord = validateAndCleanWord(word);
  cleanedWord = cleanWord(cleanedWord); */

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
