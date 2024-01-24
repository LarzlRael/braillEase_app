part of '../widgets.dart';

class TitleAndBraillePhrase extends StatelessWidget {
  final String titlePage;
  const TitleAndBraillePhrase({super.key, required this.titlePage});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: titlePage
          .split('')
          .map((e) => Column(
                children: [
                  Text(
                    e,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  /* line(), */
                  Text(
                    convertToBraillex(e),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}
