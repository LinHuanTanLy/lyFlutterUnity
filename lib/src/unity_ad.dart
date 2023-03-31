import 'package:flutter/services.dart';

import 'unity_ad_platform_interface.dart';

class LyUnityAd {
  void setCallBack(Future Function(MethodCall call)? handler) {
    return LyUnityAdPlatform.instance.setCallBack(handler);
  }

  Future<String?> getPlatformVersion() {
    return LyUnityAdPlatform.instance.getPlatformVersion();
  }

  Future<String?> init(String gameId, bool ifTestModel) {
    return LyUnityAdPlatform.instance.init(gameId, ifTestModel);
  }

  Future<String?> showInterstitialAd(String adUnitId, String gamerSid) {
    return LyUnityAdPlatform.instance.showInterstitialAd(adUnitId, gamerSid);
  }

  Future<String?> showRewardedAd(adUnitId, gamerSid) async {
    return LyUnityAdPlatform.instance.showRewardedAd(adUnitId, gamerSid);
  }

  Future<bool?> initBannerAd(adUnitId, int width, int height) async {
    return LyUnityAdPlatform.instance.initBannerAd(adUnitId, width, height);
  }
}
