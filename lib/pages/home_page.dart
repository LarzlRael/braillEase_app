part of 'pages.dart';

class HomePage extends StatelessWidget {
  final text = "a";
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    /* final listGenerate = List.generate(text.length, (index) => LetterBraile()); 
    */
    final listGenerate = getLetterConverted(text);
    return Scaffold(
      body: SizedBox.expand(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 12,
            crossAxisSpacing: 10,
          ),
          shrinkWrap: true,
          /* mainAxisSpacing: 12,
          crossAxisSpacing: 10,
          crossAxisCount: 5, */

          itemCount: listGenerate.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Text(text[index]),
                LetterBraile(
                  word: listGenerate[index],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class LetterBraile extends StatelessWidget {
  /* final letter = [true, false, true, false, true, false]; */
  final List<bool> word;
  LetterBraile({
    required this.word,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        shrinkWrap: true,
        /* physics: NeverScrollableScrollPhysics(), */
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
  const Point({super.key, required this.paint});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: paint ? Colors.blue : null,
        shape: BoxShape.circle,
        border: paint
            ? null
            : Border.all(
                color: Colors.blue,
                width: 1,
              ),
      ),
    );
  }
}
