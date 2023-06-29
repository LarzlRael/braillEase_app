part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BannerAd? _bannerAd;
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
  void initState() {
    super.initState();
    MobileAds.instance.initialize().then((InitializationStatus status) {
      loadAd();
    });
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> itemMap = items
        .map(
          (item) => FadeInRight(
            child: ButtonCategory(
              icon: item.icon,
              text: item.texto + "\n" + convertToBraillex(item.texto),
              color1: item.color1,
              color2: item.color2,
              onPress: () {
                context.push(
                  item.path,
                  extra: PageRouteParams(
                    phase: item.phase,
                    titlePage: item.texto,
                  ),
                );
              },
            ),
          ),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(appName + " ${convertToBraillex(appName)}"),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/settings');
            },
            icon: Icon(Icons.settings),
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...itemMap,
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
                  : CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

class LetterBraile extends StatelessWidget {
  final List<bool> word;
  LetterBraile({required this.word, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(13),
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 13,
        mainAxisSpacing: 13,
        children: List.generate(
          word.length,
          (index) => Point(
            paint: word[index],
          ),
        ),
      ),
    );
  }
}

class Point extends StatelessWidget {
  final bool paint;
  const Point({Key? key, required this.paint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: paint ? Colors.white : null,
        shape: BoxShape.circle,
        border: paint
            ? null
            : Border.all(
                color: Colors.white,
                width: 1,
              ),
      ),
    );
  }
}

Widget line() {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 1.5,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    width: double.infinity,
    height: 2.5,
  );
}
