import 'package:careerplanner/util/ad_manager.dart';
import 'package:firebase_admob/firebase_admob.dart';

class Ads {
  static BannerAd _bannerAd;

  static InterstitialAd _popupAd;

  static RewardedVideoAd _rewardAd;

  static void showPopupAd() {
    if (_popupAd == null) _popupAd = _createPopupAd();
    _popupAd
      ..load()
      ..show();
  }

  static void hidePopupAd() async {
    if (_popupAd != null) {
      await _popupAd.dispose();
      _popupAd = null;
    }
  }

  static InterstitialAd _createPopupAd() {
    return InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
    );
  }

  static void showRewardAd() {
    RewardedVideoAd.instance
        .load(
      targetingInfo: MobileAdTargetingInfo(),
      adUnitId: AdManager.rewardedAdUnitId,
    )
        .then((value) {
      RewardedVideoAd.instance.show();
    });
  }

  static BannerAd _createBannerAd() {
    return BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.fullBanner,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  static void showBannerAd() {
    if (_bannerAd == null) _bannerAd = _createBannerAd();
    _bannerAd
      ..load()
      ..show(anchorType: AnchorType.bottom);
  }

  static void hideBannerAd() async {
    if (_bannerAd != null) {
      await _bannerAd.dispose();
      _bannerAd = null;
    }
  }
}
