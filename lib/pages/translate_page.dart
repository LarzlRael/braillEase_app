part of 'pages.dart';

class TranslatePage extends StatefulWidget {
  final PageRouteParams titlePage;
  const TranslatePage({
    super.key,
    required this.titlePage,
  });

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  late GlobalProvider globalProvider;
  late BraileProvider braileProvider;
  TextEditingController textController = TextEditingController();
  bool isSwitched = false;
  String textBraille = "";

  /* Speach */
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  initState() {
    super.initState();
    globalProvider = Provider.of<GlobalProvider>(context, listen: false);
    _initSpeech();
    braileProvider = Provider.of<BraileProvider>(context, listen: false);
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: 'es_ES',
    );
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      textController.text = _lastWords;
      textBraille = convertToBraillex(_lastWords);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          /*  await createAndDownloadPdf(
            textBraille,
            braileProvider.selectedPagesSizes.pageFormat,
          ); */
          braileProvider.setBraileConverted = textBraille;
          context.push('/print_pdf_page');
        },
        tooltip: 'Crear pdf',
        child: Icon(Icons.picture_as_pdf),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppbar(
                    titlePage: widget.titlePage.titlePage,
                  ),
                  /* Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        // If listening is active show the recognized words
                        _speechToText.isListening
                            ? '$_lastWords'
                            // If listening isn't active but could be tell the user
                            // how to start it, otherwise indicate that speech
                            // recognition is not yet ready or not supported on
                            // the target device
                            : _speechEnabled
                                ? 'Tap the microphone to start listening...'
                                : 'Speech not available',
                      ),
                    ),
                  ), */
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: textController,
                        maxLines: 6, //or null
                        decoration: InputDecoration(
                          hintText: "Ingrese su texto aquí",
                          border: InputBorder.none,
                          suffixIcon: textController.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    textController.text = "";
                                    textController.clear();
                                    setState(() {
                                      textBraille = "";
                                    });
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: globalProvider.pickerColor,
                                  ),
                                )
                              : null,
                        ),
                        onChanged: (value) {
                          setState(() {
                            textBraille = convertToBraillex(value);
                          });
                        },
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Card(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            width: double.infinity,
                            height: 150,
                            child: Text(
                              textBraille,
                              style: textTheme.bodySmall!.copyWith(
                                fontSize: 20,
                                color: globalProvider.pickerColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Row(
                          children: [
                            Text(
                              "Traducción en Braille",
                              style: textTheme.titleMedium!.copyWith(
                                fontSize: 13,
                                color:
                                    globalProvider.pickerColor.withOpacity(0.7),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 5),
                            textBraille.isEmpty
                                ? SizedBox()
                                : IconButton(
                                    onPressed: () async {
                                      await Clipboard.setData(
                                          ClipboardData(text: textBraille));

                                      globalProvider.showSnackBar(
                                        backgroundColor: Colors.green,
                                        context,
                                        "Texto copiado al portapapeles",
                                      );
                                    },
                                    icon: Icon(
                                      Icons.copy,
                                      color: globalProvider.pickerColor,
                                    ),
                                  ),
                          ],
                        ),
                        bottom: 10,
                        right: 10,
                      ),
                    ],
                  ),
                ],
              ),
              BannerWidgetPositioned(),
            ],
          ),
        ),
      ),
    );
  }
}
