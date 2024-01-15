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
  late BrailleProvider braileProvider;
  TextEditingController textController = TextEditingController();
  bool isSwitched = false;
  String textBraille = "";

  /* Speach */
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  double fontSize = 20;

  @override
  initState() {
    super.initState();
    globalProvider = context.read<GlobalProvider>();
    braileProvider = context.read<BrailleProvider>();
    textController.text = braileProvider.getNormalText;
    textBraille = convertToBraillex(textController.text);
    InterstitialAdManager.loadAd();
    _initSpeech();
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

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      textController.text = _lastWords;
      textBraille = convertToBraillex(_lastWords);
    });
  }

  @override
  void dispose() {
    _speechToText.cancel();
    InterstitialAdManager.disposeAd();
    super.dispose();
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    /* textController.text = braileProvider.getNormalText; */
    return Scaffold(
      floatingActionButton: textController.text.isNotEmpty
          ? FloatingActionButton.extended(
              label: Text('Crear PDF'),
              icon: Icon(Icons.picture_as_pdf_rounded),
              onPressed: () {
                if (addCounterIntersitialAd()) {
                  InterstitialAdManager.showAd();
                }
                braileProvider.setBraileConverted = textBraille;
                context.push('/print_pdf_page');
              },
              tooltip: 'Crear pdf',
            )
          : null,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppbar(
                      titlePage: widget.titlePage.titlePage,
                      actions: [
                        IconButton(
                          onPressed: () async {
                            await _speechToText.isNotListening
                                ? _startListening()
                                : _stopListening();
                          },
                          icon: Icon(
                            _speechToText.isNotListening
                                ? Icons.mic_off
                                : Icons.mic,
                          ),
                        ),
                      ],
                    ),
                    /* Row(
                      children: [
                        Expanded(
                          child: Slider(
                            label: "Tamaño de letra",
                            value: fontSize,
                            max: 50,
                            min: 10,
                            onChanged: (value) {
                              setState(() {
                                fontSize = value;
                              });
                            },
                          ),
                        ),
                        PickColorButton(),
                      ],
                    ), */
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: textController,
                          maxLines: 7,
                          style: textTheme.bodySmall!.copyWith(
                            fontSize: fontSize,
                            /* color: braileProvider.getPickerTextColor, */
                            color: globalProvider.pickerColor,
                            fontWeight: FontWeight.normal,
                          ),
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
                              braileProvider.setNormalText = value;
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
                              child: TextField(
                                readOnly: true,
                                maxLines: 7,
                                controller: TextEditingController(
                                  text: textBraille,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: textTheme.bodySmall!.copyWith(
                                  fontSize: fontSize + 5,
                                  /* color: braileProvider.getPickerTextColor, */
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
                                  color: globalProvider.pickerColor
                                      .withOpacity(0.7),
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
                                          backgroundColor: Colors.blue,
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
              ),
              BannerWidgetPositioned(),
            ],
          ),
        ),
      ),
    );
  }
}
