part of 'pages.dart';

class PhraseMakerPage extends StatefulWidget {
  const PhraseMakerPage({super.key});

  @override
  State<PhraseMakerPage> createState() => _PhraseMakerPageState();
}

class _PhraseMakerPageState extends State<PhraseMakerPage> {
  late GlobalProvider globalProvider;
  String phrase = "";
  @override
  void initState() {
    super.initState();
    globalProvider = context.read<GlobalProvider>();
    setState(() {
      phrase = globalProvider.setPhrase;
    });
  }

  @override
  Widget build(BuildContext context) {
    final listGenerate = getLetterConverted(phrase);
    return WillPopScope(
      onWillPop: () async {
        globalProvider.setPhrase = phrase;
        return true;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: showDialogPicker,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Phrase Maker'),
          actions: [
            if (phrase.isNotEmpty)
              IconButton(
                tooltip: "Borrar letra",
                onPressed: () {
                  setState(() {
                    phrase = phrase.substring(0, phrase.length - 1);
                  });
                },
                icon: Icon(Icons.backspace),
              ),
            if (phrase.isNotEmpty)
              IconButton(
                tooltip: "Borrar todo",
                onPressed: () {
                  setState(() {
                    phrase = "";
                  });
                },
                icon: Icon(Icons.cancel),
              ),
            if (phrase.isEmpty)
              IconButton(
                onPressed: () {
                  showDialogPicker();
                },
                icon: Icon(Icons.add),
              ),
          ],
        ),
        body: phrase.isEmpty
            ? NoInformation(
                icon: Icons.info_outline,
                text: "Pulsa en el boton + para agregar letras",
                showButton: false,
                iconButton: Icons.add_a_photo,
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .65,
                      child: GridView.builder(
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
                            child: Stack(
                              children: [
                                FadeInOpacity(
                                  duration: Duration(milliseconds: 500),
                                  child: BraileLetterCardPickeed(
                                    globalProvider: globalProvider,
                                    listGenerated: listGenerated,
                                    letter: letter,
                                  ),
                                ),
                                Positioned(
                                  top: -13,
                                  right: -13,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        phrase =
                                            phrase.replaceFirst(letter, '');
                                      });
                                    },
                                    icon: Icon(
                                      Icons.cancel,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    ListTile(
                      title: Container(
                        width: double.infinity,
                        child: Text(
                          phrase,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: phrase));

                          globalProvider.showSnackBar(
                            backgroundColor: Colors.blue,
                            context,
                            "Texto copiado al portapapeles",
                          );
                        },
                        icon: phrase.isNotEmpty
                            ? Icon(
                                Icons.copy,
                                color: globalProvider.pickerColor,
                              )
                            : SizedBox(),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void showDialogPicker() {
    BuildContext mainContext = context;
    showDialog(
      context: mainContext,
      builder: (BuildContext context) {
        final brailleProvider = context.read<BrailleProvider>();
        String wordToShow = '';
        List<String> matchingCharacters = [];

        /* globalProvider.clearWord(); */
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.add),
              SizedBox(width: 10),
              Text(
                'Agregar letra',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              void selectedAndPop(String x) {
                setState(() {
                  phrase += x.toString();
                });
                brailleProvider.clearWord();
                context.pop();
              }

              void handleWordChanged(List<bool> word) {
                // Lógica para manejar el array actualizado

                matchingCharacters.clear();
                brailleMap.forEach((character, array) {
                  if (listEquals(array, word)) {
                    /* setState(() {
                      wordToShow = character;
                    }); */
                    matchingCharacters.add(character);
                  }
                });

                if (matchingCharacters.isNotEmpty) {
                  setState(() {
                    wordToShow = matchingCharacters[0];
                  });
                } else {
                  setState(() {
                    wordToShow = "";
                  });
                }
              }

              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Provider.of<GlobalProvider>(context, listen: false)
                          .pickerColor,
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
                        matchingCharacters.length == 1
                            ? Text(
                                textInAlphabet(wordToShow),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: matchingCharacters
                                    .map(
                                      (e) => FilledButton(
                                          onPressed: () {
                                            selectedAndPop(e);
                                          },
                                          child: Text(e)),
                                    )
                                    .toList())
                        /* Text(
                          textInAlphabet(wordToShow),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ), */
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  brailleProvider.clearWord();
                },
                icon: Icon(Icons.backspace)),
            IconButton(
                onPressed: () {
                  brailleProvider.fillWord();
                },
                icon: Icon(Icons.apps_rounded)),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  phrase += wordToShow;
                });
                brailleProvider.clearWord();
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
