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
        return StatefulBuilder(
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

            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 5),
                  Text(
                    'Agregar: $wordToShow',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              content: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 300,
                child: Column(
                  children: [
                    LetterBraileCreator(
                      onWordChanged: handleWordChanged,
                      childAspectRatio: 1.5,
                    ),
                    line(),
                    Text(
                      textInAlphabet(wordToShow),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.apps_rounded)),
                IconButton(onPressed: () {}, icon: Icon(Icons.backspace)),
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
      },
    );
  }
}
