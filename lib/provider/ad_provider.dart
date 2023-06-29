part of 'providers.dart';

class AdProvider with ChangeNotifier {
  late BannerAd _bannerAd;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;
  void loadBannerAd() async {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _isLoaded = true;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
    await _bannerAd.load();
  }

  Widget getBannerAdWidget() {
    if (!_isLoaded) {
      return SizedBox(); // No mostrar nada si el anuncio no se ha cargado aún
    }

    return SizedBox(
      width: _bannerAd.size.width.toDouble(),
      height: _bannerAd.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd),
    );
  }
}
