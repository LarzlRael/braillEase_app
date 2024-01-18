part of 'utils.dart';

void loadIntersitialAd(InterstitialAd interstitialAd) {
  InterstitialAd.load(
    adUnitId: Environment.admobIntersitial,
    request: const AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      // Called when an ad is successfully received.
      onAdLoaded: (ad) {
        ad.fullScreenContentCallback = FullScreenContentCallback(
            // Called when the ad showed the full screen content.
            onAdShowedFullScreenContent: (ad) {},
            // Called when an impression occurs on the ad.
            onAdImpression: (ad) {},
            // Called when the ad failed to show full screen content.
            onAdFailedToShowFullScreenContent: (ad, err) {
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            // Called when the ad dismissed full screen content.
            onAdDismissedFullScreenContent: (ad) {
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            // Called when a click is recorded for an ad.
            onAdClicked: (ad) {});

        debugPrint('$ad loaded.');
        // Keep a reference to the ad so you can show it later.
        interstitialAd = ad;
      },
      // Called when an ad request failed.
      onAdFailedToLoad: (LoadAdError error) {
        debugPrint('InterstitialAd failed to load: $error');
      },
    ),
  );
}

Future<bool> addCounterIntersitialAd() async {
  const MAXCOUNT = 4;
  final keyValueStorageServiceImpl = KeyValueStorageServiceImpl();
  final getCountIntersitialAd =
      await keyValueStorageServiceImpl.getValue<int>(COUNTER_AD_KEY) ?? 0;

  await keyValueStorageServiceImpl.setKeyValue<int>(
      COUNTER_AD_KEY, getCountIntersitialAd + 1);

  if (getCountIntersitialAd == MAXCOUNT) {
    await keyValueStorageServiceImpl.setKeyValue<int>(COUNTER_AD_KEY, 0);
    return true;
  }
  return false;
}
