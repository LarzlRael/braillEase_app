part of 'pages.dart';

class DetailLetterPage extends ConsumerWidget {
  final String letter;
  const DetailLetterPage({
    super.key,
    required this.letter,
  });

  @override
  Widget build(BuildContext context, ref) {
    final globalState = ref.watch(globalProvider);

    final size = MediaQuery.of(context).size;

    final convertedLetter = getOneLetterConverted(
        letter.length > 1 ? letter.substring(0, letter.length - 1) : letter);
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
                /* placeholderBuilder: (context, size, widget) {
                  return CircularProgressIndicator();
                }, */
                child: Container(
                  width: 180,
                  height: 300,
                  /* margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.10,
                    vertical: size.height * 0.05,
                  ), */
                  child: Card(
                    color: globalState.currentColor,
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
                          textInAlphabet(letter, true),
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
