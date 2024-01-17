part of 'pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    List<Widget> itemMap = items
        .map(
          (item) => FadeInRight(
            child: ButtonCategory(
              icon: item.icon,
              title: Wrap(
                children: getTitleAndPhase(item.path)
                    .split('')
                    .map((e) => Column(
                          children: [
                            Text(
                              e,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            /* line(), */
                            Text(
                              convertToBraillex(e),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ))
                    .toList(),
              ),
              color1: item.color1,
              color2: item.color2,
              onPress: () {
                /* print(getTitleAndPhase(item.path)); */
                context.push(
                  item.path,
                  /* extra: PageRouteParams(
                    phase: item.phase,
                    titlePage: item.texto,
                  ), */
                );
              },
            ),
          ),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(appName + " ${convertToBraillex(appName)}"),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/settings');
            },
            icon: Icon(Icons.settings),
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...itemMap,
                ],
              ),
            ),
            BannerWidgetPositioned(),
          ],
        ),
      ),
    );
  }
}

class LetterBraile extends StatelessWidget {
  final List<bool> word;
  final double? childAspectRatio;
  LetterBraile({
    required this.word,
    Key? key,
    this.childAspectRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(13),
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 13,
        childAspectRatio: childAspectRatio ?? 1,
        mainAxisSpacing: 13,
        children: List.generate(
          word.length,
          (index) => Point(
            paint: word[index],
          ),
        ),
      ),
    );
  }
}

class Point extends StatelessWidget {
  final bool paint;
  const Point({Key? key, required this.paint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: paint ? Colors.white : null,
        shape: BoxShape.circle,
        border: paint
            ? null
            : Border.all(
                color: Colors.white,
                width: 1,
              ),
      ),
    );
  }
}

Widget line() {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 1.5,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    width: double.infinity,
    height: 2.5,
  );
}
