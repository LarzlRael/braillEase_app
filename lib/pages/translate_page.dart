part of 'pages.dart';

class TranslatePage extends HookConsumerWidget {
  final PageRouteParams titlePage;
  const TranslatePage({
    super.key,
    required this.titlePage,
  });

  @override
  Widget build(BuildContext context, ref) {
    final textController = useTextEditingController();
    final textBraille = useState("");
    useEffect(() {
      textController.text = ref.read(brailleProvider).normalText;
      textBraille.value = convertToBraillex(textController.text);
      InterstitialAdManager.loadAd();
      return () {
        textController.dispose();
      };
    }, []);

    final globalProviderS = ref.watch(globalProvider);
    final textTheme = Theme.of(context).textTheme;

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
                      titlePage: titlePage.titlePage,
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
                                      .setBraileConverted(textBraille.value);
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
                                maxLines: 9,
                                controller: TextEditingController(
                                  text: textBraille.value,
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
                              textBraille.value.isEmpty
                                  ? SizedBox()
                                  : IconButton(
                                      onPressed: () async {
                                        await Clipboard.setData(ClipboardData(
                                            text: textBraille.value));

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
                  onClear: () {
                    textController.clear();
                    textBraille.value = "";
                  },
                  focusNode: FocusNode(),
                  onTextChange: (text) {
                    ref.read(brailleProvider.notifier).setNormalText(text);
                    textBraille.value = convertToBraillex(text);
                  },
                  onSpeechResult: (value) {
                    textBraille.value =
                        convertToBraillex(value.recognizedWords);

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
