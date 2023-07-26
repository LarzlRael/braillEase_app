part of 'pages.dart';

class PhraseMakerPage extends StatefulWidget {
  const PhraseMakerPage({super.key});

  @override
  State<PhraseMakerPage> createState() => _PhraseMakerPageState();
}

class _PhraseMakerPageState extends State<PhraseMakerPage> {
  late GlobalProvider globalProvider;
  TextEditingController textFormController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    globalProvider = context.read<GlobalProvider>();
    _focusNode.requestFocus();
  }

  void _performActionAndScrollToBottom() {
    // Realiza la acción que desencadena el desplazamiento automático.
    // Por ejemplo, si quieres agregar un nuevo elemento, agrega el elemento a la lista de elementos que alimenta el GridView.

    // Luego de realizar la acción, haremos que el GridView se desplace automáticamente hacia abajo.
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(builder: (_, globalProvider, __) {
      final listGenerate = getLetterConverted(textFormController.text);
      final phrase = textFormController.text;
      return Scaffold(
        /* floatingActionButton: FloatingActionButton(
          onPressed: phrase.isEmpty
              ? showDialogPicker
              : () async {
                  await Clipboard.setData(ClipboardData(text: phrase));
                  globalProvider.showSnackBar(
                    backgroundColor: Colors.blue,
                    context,
                    "Texto copiado al portapapeles",
                  );
                },
          child: phrase.isEmpty
              ? Icon(FontAwesomeIcons.braille)
              : Icon(FontAwesomeIcons.clipboard),
        ), */
        appBar: AppBar(
          title: Text('Creador de frases'),
          actions: [
            /*  if (phrase.isNotEmpty)
              IconButton(
                tooltip: "Borrar letra",
                onPressed: () {
                  /*  globalProvider.setPhrase =
                      phrase.substring(0, phrase.length - 1); */
                  textFormController.text = textFormController.text
                      .substring(0, textFormController.text.length - 1);
                  setState(() {});
                  /* _focusNode.end */
                },
                icon: Icon(Icons.backspace),
              ), */
            if (phrase.isNotEmpty)
              IconButton(
                tooltip: "Borrar todo",
                onPressed: () {
                  /* globalProvider.setPhrase = ''; */
                  textFormController.text = '';
                  setState(() {});
                },
                icon: Icon(Icons.cancel),
              ),
            /* if (phrase.isEmpty) */
            IconButton(
              onPressed: () {
                showDialogPicker();
              },
              icon: Icon(FontAwesomeIcons.braille),
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Flexible(
                  child: phrase.isEmpty
                      ? FadeInOpacity(
                          duration: Duration(milliseconds: 500),
                          child: NoInformation(
                            icon: Icons.info_outline,
                            text: "Pulsa en el boton + para agregar letras",
                            showButton: false,
                            iconButton: Icons.add_a_photo,
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .75,
                                child: GridView.builder(
                                  controller: scrollController,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5,
                                    crossAxisSpacing: 1,
                                    mainAxisSpacing: 1,
                                    childAspectRatio: MediaQuery.of(context)
                                            .size
                                            .width /
                                        (MediaQuery.of(context).size.height /
                                            1.15),
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
                                            duration:
                                                Duration(milliseconds: 500),
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
                                                /* globalProvider.setPhrase =
                                                  phrase.replaceFirst(letter, ''); */
                                                textFormController.text = phrase
                                                    .replaceFirst(letter, '');
                                                setState(() {});
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
                            ],
                          ),
                        ),
                ),
                Container(
                  /* margin: EdgeInsets.only(top: 20), */
                  child: Row(
                    children: [
                      Container(
                        child: Flexible(
                          child: Card(
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              focusNode: _focusNode,
                              controller: textFormController,
                              maxLines: 3,
                              minLines: 1,
                              onChanged: (value) {
                                setState(() {});
                                if (textFormController.text.length > 5)
                                  _performActionAndScrollToBottom();
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Escribe una frase',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                          ),
                          /* padding: EdgeInsets.all(10), */
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        margin: textFormController.text.isEmpty
                            ? EdgeInsets.all(0)
                            : EdgeInsets.symmetric(horizontal: 5),
                        child: textFormController.text.isEmpty
                            ? SizedBox()
                            : FloatingActionButton(
                                shape: StadiumBorder(),
                                onPressed: () async {
                                  await Clipboard.setData(ClipboardData(
                                    text: convertToBraillex(
                                        textFormController.text),
                                  ));
                                  globalProvider.showSnackBar(
                                    backgroundColor: Colors.blue,
                                    context,
                                    "Texto copiado al portapapeles",
                                  );
                                },
                                child: Icon(Icons.copy_outlined, size: 30),
                              ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
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
              IconButton(
                onPressed: brailleProvider.fillWord,
                icon: Icon(Icons.apps_rounded),
              ),
              SizedBox(width: 10),
              Text(
                'Agregar letra',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Spacer(),
              IconButton(onPressed: context.pop, icon: Icon(Icons.cancel)),
            ],
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              void selectedAndPop(String x) {
                globalProvider.setPhrase =
                    globalProvider.getPhrase + x.toString();
                brailleProvider.clearWord();
                textFormController.text =
                    textFormController.text + x.toString();
                /* context.pop(); */
                setState(() {
                  matchingCharacters.clear();
                });
              }

              void handleWordChanged(List<bool> word) {
                // Lógica para manejar el array actualizado
                matchingCharacters.clear();
                brailleMap.forEach((character, array) {
                  if (listEquals(array, word)) {
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
                            ? FadeInOpacity(
                                duration: Duration(milliseconds: 250),
                                child: Text(
                                  textInAlphabet(wordToShow),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: matchingCharacters
                                    .map(
                                      (e) => FadeInOpacity(
                                        duration: Duration(milliseconds: 400),
                                        child: FilledButton(
                                          /* style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ), */
                                          onPressed: () {
                                            selectedAndPop(e);
                                          },
                                          child: Text(e),
                                        ),
                                      ),
                                    )
                                    .toList())
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                context.pop();
              },
            ),
            IconButton(
                onPressed: () {
                  brailleProvider.clearWord();
                  setState(() {
                    matchingCharacters.clear();
                    wordToShow = "";
                  });
                },
                icon: Icon(Icons.backspace)),
            /*
            IconButton(
                onPressed: () {
                  brailleProvider.fillWord();
                },
                icon: Icon(Icons.apps_rounded)), */
            TextButton(
              child: const Text('AGREGAR'),
              onPressed: () {
                if (matchingCharacters.isEmpty) {
                  globalProvider.setPhrase = globalProvider.getPhrase + " ";
                  return;
                }
                globalProvider.setPhrase =
                    globalProvider.getPhrase + matchingCharacters[0];

                brailleProvider.clearWord();

                /* context.pop(); */
              },
            ),
          ],
        );
      },
    );
  }
}
