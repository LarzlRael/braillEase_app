part of 'helpers.dart';

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
