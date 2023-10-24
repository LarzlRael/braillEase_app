part of 'pages.dart';

class DetailLetterPage extends StatelessWidget {
  /* final DetailPageRouteParams detailPageRouteParams; */
  final String letter;
  const DetailLetterPage({
    super.key,
    /* required this.detailPageRouteParams, */
    required this.letter,
  });

  @override
  Widget build(BuildContext context) {
    final braileProvider = context.read<GlobalProvider>();
    final size = MediaQuery.of(context).size;
    final convertedLetter = getOneLetterConverted(letter);
    return Scaffold(
      appBar: AppBar(
        title: Text(letter + " ${convertToBraillex(letter)}"),
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: letter,
                child: Container(
                  height: size.height * 0.40,
                  width: size.width * 0.5,
                  /* margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.10,
                    vertical: size.height * 0.05,
                  ), */
                  child: Card(
                    color: braileProvider.pickerColor,
                    /* child: LetterBraile(
                      word: detailPageRouteParams.listGenerated,
                    ), */
                    child: Column(
                      children: [
                        LetterBraile(
                          childAspectRatio: 1.1,
                          word: convertedLetter,
                        ),
                        line(),
                        Text(
                          textInAlphabet(letter),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            BannerWidgetPositioned(),
          ],
        ),
      ),
    );
  }
}
