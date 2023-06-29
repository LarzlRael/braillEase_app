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
  TextEditingController textController = TextEditingController();
  bool isSwitched = false;
  String text = "";
  String textBraille = "";
  late BannerAd _bannerAd;
  bool _isLoaded = false;

  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully   received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  initState() {
    super.initState();
    globalProvider = Provider.of<GlobalProvider>(context, listen: false);
    MobileAds.instance.initialize().then((InitializationStatus status) {
      loadAd();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
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
                                      text = "";
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
                            text = value;
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
              Positioned(
                /* bottom: 10, */
                child: _isLoaded
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SizedBox(
                            width: _bannerAd!.size.width.toDouble(),
                            height: _bannerAd!.size.height.toDouble(),
                            child: AdWidget(ad: _bannerAd!),
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
