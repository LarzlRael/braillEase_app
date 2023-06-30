part of '../widgets.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late BannerAd _bannerAd;
  bool _isLoaded = false;

  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: Enviroment.admobBanner,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully   received.
        onAdLoaded: (ad) {
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
    MobileAds.instance.initialize().then((InitializationStatus status) {
      loadAd();
    });
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded
        ? SizedBox(
            width: _bannerAd.size.width.toDouble(),
            height: _bannerAd.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd),
          )
        : SizedBox();
  }
}

class BannerWidgetPositioned extends StatelessWidget {
  const BannerWidgetPositioned({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      /* bottom: 10, */
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: BannerWidget(),
        ),
      ),
    );
  }
}
