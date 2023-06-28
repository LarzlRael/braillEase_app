part of 'pages.dart';

class Abcdario extends StatelessWidget {
  static const String routeName = 'abcdario';
  const Abcdario({super.key});
  @override
  Widget build(BuildContext context) {
    final text = '123456789';

    final listGenerate = getLetterConverted(text);
    return Scaffold(
      appBar: AppBar(
        title: Text('Abcdario'),
      ),
      body: Container(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.15),
          ),
          shrinkWrap: true,
          itemCount: text.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 3,
              color: Colors.purple,
              child: Column(
                children: [
                  LetterBraile(
                    word: listGenerate[index],
                  ),
                  line(),
                  Text(
                    text[index] + " - " + text[index].toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
