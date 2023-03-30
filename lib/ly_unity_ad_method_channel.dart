import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ly_unity_ad_platform_interface.dart';

/// An implementation of [LyUnityAdPlatform] that uses method channels.
class MethodChannelLyUnityAd extends LyUnityAdPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ly_unity_ad');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  void setCallBack(Future Function(MethodCall call)? handler) {
    methodChannel.setMethodCallHandler(handler);
  }

  @override
  Future<String?> init(String gameId, bool ifTestModel) async {
    final result = await methodChannel.invokeMethod<String>(
        'init', {"gameId": gameId, "ifTestModel": ifTestModel});
    return result;
  }

  @override
  Future<String?> showInterstitialAd(adUnitId, gamerSid) async {
    final result = await methodChannel.invokeMethod<String>(
        'showInterstitialAd', {"adUnitId": adUnitId, "gamerSid": gamerSid});
    return result;
  }

  @override
  Future<String?> showRewardedAd(adUnitId, gamerSid) async {
    final result = await methodChannel.invokeMethod<String>(
        'showRewardedAd', {"adUnitId": adUnitId, "gamerSid": gamerSid});
    return result;
  }
}
