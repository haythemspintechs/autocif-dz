import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';

/// Manages interstitial lifecycle with a frequency cap so ads never
/// disrupt the core calculation loop. Triggered only after a completed
/// calculation or on "Share Result" — never on load, never mid-input.
class InterstitialAdManager {
  InterstitialAdManager._();
  static final InterstitialAdManager instance = InterstitialAdManager._();

  InterstitialAd? _interstitialAd;
  int _actionCount = 0;
  static const int _showEveryNActions = 3; // frequency cap

  void preload() {
    AdHelper.loadInterstitial(
      onLoaded: (ad) => _interstitialAd = ad,
      onFailed: (_) => _interstitialAd = null,
    );
  }

  /// Call this after a "full calculation" or "share" action.
  /// Only shows an ad every [_showEveryNActions] triggers.
  void maybeShow() {
    _actionCount++;
    if (_actionCount % _showEveryNActions != 0) return;

    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          preload();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          preload();
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
    } else {
      preload();
    }
  }
}
