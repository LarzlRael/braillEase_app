part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = "abcdefghijklmnopqrstuvwxyz";
  TextEditingController textController = TextEditingController();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> itemMap = items
        .map(
          (item) => ButtonCategory(
            icon: item.icon,
            text: item.texto + "\n" + convertToBraillex(item.texto),
            color1: item.color1,
            color2: item.color2,
            onPress: () {
              context.push(
                item.path,
                extra: PageRouteParams(
                  phase: item.phase,
                  titlePage: item.texto,
                ),
              );
            },
          ),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(appName + " ${convertToBraillex(appName)}"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: itemMap,
        ),
      ),
    );
  }
}

class LetterBraile extends StatelessWidget {
  final List<bool> word;
  LetterBraile({required this.word, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(13),
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 13,
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
