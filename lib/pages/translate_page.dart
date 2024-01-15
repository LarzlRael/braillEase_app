part of 'pages.dart';

class TranslatePage extends ConsumerStatefulWidget {
  final PageRouteParams titlePage;
  const TranslatePage({
    super.key,
    required this.titlePage,
  });

  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends ConsumerState<TranslatePage> {
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

    textController.text = ref.read(brailleProvider).normalText;
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
    final globalProviderS = ref.watch(globalProvider);
    final textTheme = Theme.of(context).textTheme;
    /* textController.text = braileProvider.getNormalText; */
    return Scaffold(
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
                        textController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.picture_as_pdf_rounded),
                                onPressed: () {
                                  if (addCounterIntersitialAd()) {
                                    InterstitialAdManager.showAd();
                                  }
                                  /* braileProvider.setBraileConverted = textBraille; */
                                  ref
                                      .read(brailleProvider.notifier)
                                      .setBraileConverted(textBraille);
                                  context.push('/print_pdf_page');
                                },
                                tooltip: 'Crear pdf',
                              )
                            : SizedBox(),
                      ],
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
                                  color: globalProviderS.pickerColor,
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
                                  color: globalProviderS.pickerColor
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

                                        ref
                                            .read(globalProvider.notifier)
                                            .showSnackBar(
                                              backgroundColor: Colors.blue,
                                              context,
                                              "Texto copiado al portapapeles",
                                            );
                                      },
                                      icon: Icon(
                                        Icons.copy,
                                        color: globalProviderS.pickerColor,
                                      ),
                                    ),
                            ],
                          ),
                          bottom: 10,
                          right: 10,
                        ),
                      ],
                    ),
                    /* Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: textController,
                          maxLines: 7,
                          style: textTheme.bodySmall!.copyWith(
                            fontSize: fontSize,
                            /* color: braileProvider.getPickerTextColor, */
                            color: globalProviderS.pickerColor,
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
                                      color: globalProviderS.pickerColor,
                                    ),
                                  )
                                : null,
                          ),
                          onChanged: (value) {
                            setState(() {
                              textBraille = convertToBraillex(value);

                              ref
                                  .read(brailleProvider.notifier)
                                  .setNormalText(value);
                            });
                          },
                        ),
                      ),
                    ), */
                  ],
                ),
              ),
              /* BannerWidgetPositioned(), */
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: TextField(
                            controller: textController,
                            minLines: 1,
                            maxLines: 3,
                            style: textTheme.bodySmall!.copyWith(
                              fontSize: fontSize,
                              /* color: braileProvider.getPickerTextColor, */
                              color: globalProviderS.pickerColor,
                              fontWeight: FontWeight.normal,
                            ),
                            decoration: InputDecoration(
                              hintText: "Ingrese su texto aquí",
                              hintStyle: TextStyle(fontSize: 14),
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
                                        color: globalProviderS.pickerColor,
                                      ),
                                    )
                                  : null,
                            ),
                            onChanged: (value) {
                              setState(() {
                                textBraille = convertToBraillex(value);

                                ref
                                    .read(brailleProvider.notifier)
                                    .setNormalText(value);
                              });
                            },
                          ),
                        ),
                      ),
                      /* IconButton(
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
                      ), */
                      SpeechButton(
                        onSpeechResult: _onSpeechResult,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
