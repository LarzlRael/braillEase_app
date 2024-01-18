part of 'pages.dart';

class TranslatePage extends HookConsumerWidget {
  final String titlePage;
  final String? phraseArg;
  const TranslatePage({
    super.key,
    this.phraseArg,
    required this.titlePage,
  });

  @override
  Widget build(BuildContext context, ref) {
    final textController = useTextEditingController(
      text: phraseArg ?? '',
    );

    final globalProviderS = ref.watch(globalProvider);

    final brailleProviderN = ref.read(brailleProvider.notifier)
      ..setNormalText(phraseArg ?? '');
    final brailleProviderS = ref.watch(brailleProvider);

    final textTheme = Theme.of(context).textTheme;

    useEffect(() {
      /* TextEditingController(
                                  text: brailleProviderS.braileConverted,
                                ) */
      InterstitialAdManager.loadAd();
      return () {
        textController.dispose();
      };
    }, []);

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
                      titlePage: titlePage,
                      actions: [
                        PopupMenu(
                          currentPage: 'translate_page/Traductor',
                        ),
                        /* textController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.picture_as_pdf_rounded),
                                onPressed: () {
                                  if (addCounterIntersitialAd()) {
                                    InterstitialAdManager.showAd();
                                  }

                                  ref
                                      .read(brailleProvider.notifier)
                                      .setBraileConverted(textBraille.value);
                                  context.push('/print_pdf_page');
                                },
                                tooltip: 'Crear pdf',
                              )
                            : SizedBox(), */
                      ],
                    ),
                    Stack(
                      children: [
                        Card(
                          child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              width: double.infinity,
                              child: Text(
                                brailleProviderS.braileConverted,
                                style: textTheme.titleMedium!.copyWith(
                                  fontSize: 20,
                                  color: globalProviderS.pickerColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
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
                              brailleProviderS.normalText.isEmpty
                                  ? SizedBox()
                                  : IconButton(
                                      onPressed: () async {
                                        /*  await Clipboard.setData(ClipboardData(
                                            text: textBraille.value)); */
                                        ShareServiceImp().shareOnlyText(
                                          appMessageOnShared(
                                            brailleProviderS.normalText,
                                            brailleProviderS.braileConverted,
                                          ),
                                        );

                                        /* ref
                                            .read(globalProvider.notifier)
                                            .showSnackBar(
                                              backgroundColor: Colors.blue,
                                              context,
                                              "Texto copiado al portapapeles",
                                            ); */
                                      },
                                      icon: Icon(
                                        Icons.copy,
                                        color: globalProviderS.pickerColor,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              /* BannerWidgetPositioned(), */
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomTextFormSpeechButton(
                  textController: textController,
                  onClear: () {
                    textController.clear();
                    brailleProviderN.clearWord();
                  },
                  focusNode: FocusNode(),
                  onTextChange: (text) {
                    brailleProviderN.setNormalText(text);
                    /* textBraille.value = convertToBraillex(text); */
                  },
                  onSpeechResult: (value) {
                    brailleProviderN.setNormalText(value.recognizedWords);
                    textController.text = value.recognizedWords;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
