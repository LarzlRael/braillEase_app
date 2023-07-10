part of 'pages.dart';

class DetailLetterPage extends StatelessWidget {
  final DetailPageRouteParams detailPageRouteParams;
  const DetailLetterPage({
    super.key,
    required this.detailPageRouteParams,
  });

  @override
  Widget build(BuildContext context) {
    final braileProvider = context.read<GlobalProvider>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(detailPageRouteParams.letter +
            " ${convertToBraillex(detailPageRouteParams.letter)}"),
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: detailPageRouteParams.letter,
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
                          word: detailPageRouteParams.listGenerated,
                        ),
                        line(),
                        Text(
                          textInAlphabet(detailPageRouteParams.letter),
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
