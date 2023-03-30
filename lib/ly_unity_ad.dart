import 'package:flutter/services.dart';

import 'ly_unity_ad_platform_interface.dart';

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

  Future<String?> showInterstitialAd(String adUnitId,String gamerSid) {
    return LyUnityAdPlatform.instance.showInterstitialAd(adUnitId,gamerSid);
  }
}
