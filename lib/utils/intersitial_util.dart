part of 'utils.dart';

class InterstitialAdManager {
  static InterstitialAd? _interstitialAd;
  static bool _isAdLoaded = false;

  static void loadAd() {
    if (!_isAdLoaded) {
      InterstitialAd.load(
        adUnitId: Environment.admobIntersitial,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {},
              onAdImpression: (ad) {},
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
              },
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
                _isAdLoaded =
                    false; // Marcar el anuncio como no cargado al cerrarlo
              },
              onAdClicked: (ad) {},
            );

            _interstitialAd = ad;
            _isAdLoaded = true; // Marcar el anuncio como cargado correctamente
            debugPrint('$ad loaded.');
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
            _isAdLoaded =
                false; // Marcar el anuncio como no cargado si falla la carga
          },
        ),
      );
    }
  }

  static Future<void> verifyAndShowAd() async {
    final verifyCounter = await addCounterIntersitialAd();
    if (_interstitialAd != null && _isAdLoaded && verifyCounter) {
      _interstitialAd!.show();
    } else {
      // Si el anuncio no está cargado, vuelve a cargarlo y muestra después de la carga
      loadAd();
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          _interstitialAd?.dispose();
          _interstitialAd = null;
        },
      );
    }
  }

  static void disposeAd() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _isAdLoaded = false;
  }
}
