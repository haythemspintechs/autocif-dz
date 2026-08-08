import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Centralized AdMob configuration and initialization.
/// Uses Google's official demo/test ad unit IDs during development [web:17].
/// Replace with production ad unit IDs before release, gated by
/// kReleaseMode / a remote-config flag.
class AdHelper {
  AdHelper._();

  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  /// Banner Ad Unit ID (test IDs shown; swap for production before release)
  static String get bannerAdUnitId {
    if (kDebugMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111' // Android test banner
          : 'ca-app-pub-3940256099942544/2934735716'; // iOS test banner
    }
    return Platform.isAndroid
        ? 'YOUR_ANDROID_PRODUCTION_BANNER_ID'
        : 'YOUR_IOS_PRODUCTION_BANNER_ID';
  }

  /// Interstitial Ad Unit ID (test IDs shown; swap for production before release)
  static String get interstitialAdUnitId {
    if (kDebugMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712' // Android test interstitial
          : 'ca-app-pub-3940256099942544/4411468910'; // iOS test interstitial
    }
    return Platform.isAndroid
        ? 'YOUR_ANDROID_PRODUCTION_INTERSTITIAL_ID'
        : 'YOUR_IOS_PRODUCTION_INTERSTITIAL_ID';
  }

  static AdRequest get defaultRequest => const AdRequest();

  /// Load a banner ad. Caller is responsible for disposing.
  static BannerAd loadBanner({
    required void Function(Ad) onLoaded,
    required void Function(Ad, LoadAdError) onFailed,
    AdSize size = AdSize.banner,
  }) {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: size,
      request: defaultRequest,
      listener: BannerAdListener(
        onAdLoaded: onLoaded,
        onAdFailedToLoad: onFailed,
      ),
    )..load();
  }

  /// Load an interstitial ad. Should be shown only after a completed
  /// calculation flow — never on app launch (non-intrusive UX rule).
  static void loadInterstitial({
    required void Function(InterstitialAd) onLoaded,
    required void Function(LoadAdError) onFailed,
  }) {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: defaultRequest,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onLoaded,
        onAdFailedToLoad: onFailed,
      ),
    );
  }
}