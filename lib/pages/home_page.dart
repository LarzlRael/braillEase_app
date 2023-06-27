part of 'pages.dart';

const MINSLIDER = 5.0;
const MAXSLIDER = 10.0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = "hola a todos we";
  TextEditingController textController = TextEditingController();
  double _currentSliderValue = 5;

  @override
  Widget build(BuildContext context) {
    final listGenerate = getLetterConverted(text);

    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        centerTitle: true,
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        print("width: $width");
        print("height: $height");
        print(MediaQuery.of(context).size.width);
        print(MediaQuery.of(context).size.height);
        return SizedBox.expand(
          child: Column(
            children: [
              Slider(
                value: _currentSliderValue,
                min: MINSLIDER,
                max: MAXSLIDER,
                /* divisions: maxSlider.toInt() - minSlider.toInt(), */
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: "Escribe algo",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                },
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _currentSliderValue.toInt(),
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / .9),
                  ),
                  shrinkWrap: true,
                  itemCount: text.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      color: Colors.purple,
                      child: Column(
                        children: [
                          LetterBraile(
                            word: listGenerate[index],
                          ),
                          line(),
                          Text(
                            text[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class LetterBraile extends StatelessWidget {
  final List<bool> word;
  LetterBraile({
    required this.word,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
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
      margin: const EdgeInsets.all(5),
      width: 5,
      height: 5,
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
    margin: EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    width: double.infinity,
    height: 3,
  );
}
