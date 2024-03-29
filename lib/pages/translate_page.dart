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
    final brailleProviderS = ref.watch(brailleProvider);

    final brailleProviderN = ref.read(brailleProvider.notifier);

    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    useEffect(() {
      Future.delayed(Duration.zero, () {
        brailleProviderN.setNormalText(textController.text);
      });
      return () {
        /* textController.dispose(); */
      };
    }, [textController.text]);

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
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: size.height * 0.6,
                          child: Card(
                            child: SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                width: double.infinity,
                                child: Text(
                                  brailleProviderS.braileConverted,
                                  style: textTheme.titleMedium!.copyWith(
                                    fontSize: 20,
                                    color: globalProviderS.currentColor,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                                  color: globalProviderS.currentColor
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
                                        color: globalProviderS.currentColor,
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
