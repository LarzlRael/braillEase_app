part of 'pages.dart';

/* class PhraseMakerPage extends ConsumerStatefulWidget {
  final String? phrase;
  const PhraseMakerPage({super.key, this.phrase});
  @override
  _PhraseMakerPageState createState() => _PhraseMakerPageState();
} */

class PhraseMakerPage extends HookConsumerWidget {
  final String? phraseArg;

  PhraseMakerPage({super.key, required this.phraseArg});
  @override
  Widget build(BuildContext context, ref) {
    final scrollController = useScrollController();
    final textController = useTextEditingController();
    final _focusNode = FocusNode();
    final brailleProviderN = ref.watch(brailleProvider.notifier);
    final phrase = useState(phraseArg ?? '');
    final listGenerate =
        useState<List<List<bool>>>(getLetterConverted(phrase.value));

    useEffect(() {
      listGenerate.value = getLetterConverted(phrase.value);
    }, [phrase.value]);

    useEffect(() {
      /* textFormController.text = phraseArg ?? ''; */
      InterstitialAdManager.loadAd();
      return () {
        /* textFormController.dispose();
        InterstitialAdManager.disposeAd(); */
      };
    }, []);

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Creador de frases'),
        actions: [
          if (phrase.value.isNotEmpty)
            IconButton(
              tooltip: "Borrar todo",
              onPressed: () {
                /* globalProvider.setPhrase = ''; */
                brailleProviderN.setNormalText('');
                /* textFormController.text = ''; */
                phrase.value = '';
              },
              icon: Icon(Icons.cancel),
            ),
          IconButton(
            onPressed: () {
              showDialogPicker(
                context,
                ref,
              );
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
                child: phrase.value.isEmpty
                    ? FadeInOpacity(
                        duration: Duration(milliseconds: 500),
                        child: NoInformation(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(_focusNode);
                          },
                          icon: Icons.info_outline,
                          text: "Escribe una frase para comenzar",
                          showButton: false,
                          iconButton: Icons.add_a_photo,
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * .75,
                              child: GridView.builder(
                                controller: scrollController,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 1,
                                  mainAxisSpacing: 1,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height /
                                              1.15),
                                ),
                                shrinkWrap: true,
                                itemCount: listGenerate.value.length,
                                itemBuilder: (_, int index) {
                                  final letter = phrase.value[index];
                                  final listGenerated =
                                      listGenerate.value[index];
                                  return GestureDetector(
                                    onTap: () =>
                                        context.push('/details/$letter'),
                                    child: Stack(
                                      children: [
                                        FadeInOpacity(
                                          duration: Duration(milliseconds: 500),
                                          child: BraileLetterCardPickeed(
                                            globalState:
                                                ref.watch(globalProvider),
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
                                              phrase.value = phrase.value
                                                  .replaceFirst(letter, '');
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
                /* child: Row(
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
                                if (addCounterIntersitialAd()) {
                                  InterstitialAdManager.showAd();
                                }
                                await Clipboard.setData(ClipboardData(
                                  text: convertToBraillex(
                                      textFormController.text),
                                ));
                                globalProviderN.showSnackBar(
                                  backgroundColor: Colors.blue,
                                  context,
                                  "Texto copiado al portapapeles",
                                );
                              },
                              child: Icon(Icons.copy_outlined, size: 30),
                            ),
                    )
                  ],
                ), */
                child: CustomTextFormSpeechButton(
                  textController: textController,
                  focusNode: _focusNode,
                  /* initialValue: phrase.value, */
                  onTextChange: (value) {
                    print(value);
                    /* if (textFormController.text.length > 5) {
                      _performActionAndScrollToBottom();
                    } */
                    /* textFormController.text = value; */
                    phrase.value = value;
                  },
                  onSpeechResult: (value) {
                    /* if (textFormController.text.length > 5)
                      _performActionAndScrollToBottom(); */
                    /* textFormController.text = value.recognizedWords; */
                    phrase.value = phrase.value + value.recognizedWords;
                  },
                  onClear: () {
                    phrase.value = '';
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDialogPicker(
    BuildContext context,
    WidgetRef ref,
    /* ValueNotifier pharse, */
  ) {
    BuildContext mainContext = context;
    showDialog(
      context: mainContext,
      builder: (BuildContext context) {
        final brailleProviderN = ref.read(brailleProvider.notifier);
        final brailleProviderS = ref.watch(brailleProvider);

        String wordToShow = '';
        List<String> matchingCharacters = [];

        /* globalProvider.clearWord(); */
        return AlertDialog(
          title: Row(
            children: [
              IconButton(
                onPressed: brailleProviderN.fillWord,
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
                brailleProviderN
                    .setNormalText(brailleProviderS.normalText + x.toString());

                brailleProviderN.clearWord();

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
                      color: ref.watch(globalProvider).pickerColor,
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
                                  textInAlphabet(wordToShow, false),
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
                  brailleProviderN.clearWord();

                  matchingCharacters.clear();
                  wordToShow = "";
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
                  brailleProviderN
                      .setNormalText(brailleProviderS.normalText + " ");

                  return;
                }
                /* globalProvider.setPhrase =
                    globalProvider.getPhrase + matchingCharacters[0]; */
                brailleProviderN.setNormalText(
                    brailleProviderS.normalText + matchingCharacters[0]);

                brailleProviderN.clearWord();

                /* context.pop(); */
              },
            ),
          ],
        );
      },
    );
  }
}
