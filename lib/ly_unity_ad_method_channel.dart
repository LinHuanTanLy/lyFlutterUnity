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
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
