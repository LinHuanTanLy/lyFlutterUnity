
import 'ly_unity_ad_platform_interface.dart';

class LyUnityAd {
  Future<String?> getPlatformVersion() {
    return LyUnityAdPlatform.instance.getPlatformVersion();
  }
}
