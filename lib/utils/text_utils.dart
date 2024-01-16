part of 'utils.dart';

extension StringCasingExtension on String {
  String toCapitalize() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalize())
      .join(' ');
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}

bool isInAlphabet(String character) {
  final pattern = r'^[a-zA-Z]$';
  final regex = RegExp(pattern);
  return regex.hasMatch(character);
}

String textInAlphabet(String character) {
  return isInAlphabet(character)
      ? character + " - " + character.toUpperCase()
      : character;
}

String clearMessageId(String? id) {
  return id?.replaceAll(':', '').replaceAll('%', '') ?? '';
}

String appMessageOnShared(String normalText, String brailleText) {
  return """
🤔En texto $normalText:

😎En braille $brailleText

Enviado desde $appName
""";
}
