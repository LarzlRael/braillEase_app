part of 'pages.dart';

class PhraseMakerPage extends StatefulWidget {
  const PhraseMakerPage({super.key});

  @override
  State<PhraseMakerPage> createState() => _PhraseMakerPageState();
}

class _PhraseMakerPageState extends State<PhraseMakerPage> {
  /* String word = "";
  void handleWordChanged(List<bool> word) {
    // Lógica para manejar el array actualizado

    brailleMap.forEach((character, array) {
      if (listEquals(array, word)) {
        setState(() {
          this.word = character;
        });
      } /* else {
        setState(() {
          this.word = '';
        });
      } */
    });
  } */

  String phrase = "";
  @override
  Widget build(BuildContext context) {
    final globalProvider = context.read<GlobalProvider>();
    final listGenerate = getLetterConverted(phrase);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogPicker();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Phrase Maker'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.15),
        ),
        shrinkWrap: true,
        itemCount: listGenerate.length,
        itemBuilder: (_, int index) {
          final letter = phrase[index];
          final listGenerated = listGenerate[index];
          return GestureDetector(
            onTap: () {
              /* globalProvider.showSnackBar(
                context,
                letter,
                backgroundColor: Colors.blue,
              ); */
            },
            child: BraileLetterCardPickeed(
              globalProvider: globalProvider,
              listGenerated: listGenerated,
              letter: letter,
            ),
          );
        },
      ),
    );
  }

  void showDialogPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String wordToShow = '';

        return AlertDialog(
          title: const Text('Escoge un color'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              void handleWordChanged(List<bool> word) {
                // Lógica para manejar el array actualizado

                brailleMap.forEach((character, array) {
                  if (listEquals(array, word)) {
                    setState(() {
                      wordToShow = character;
                    });
                  }
                });
              }

              return Column(
                children: [
                  Text('Palabra: $wordToShow'),
                  Container(
                    width: 200,
                    height: 600,
                    color: Colors.blue,
                    child: LetterBraileCreator(
                      onWordChanged: handleWordChanged,
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  phrase += wordToShow;
                });
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
