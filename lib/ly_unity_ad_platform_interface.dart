import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ly_unity_ad_method_channel.dart';

abstract class LyUnityAdPlatform extends PlatformInterface {
  /// Constructs a LyUnityAdPlatform.
  LyUnityAdPlatform() : super(token: _token);

  static final Object _token = Object();

  static LyUnityAdPlatform _instance = MethodChannelLyUnityAd();

  /// The default instance of [LyUnityAdPlatform] to use.
  ///
  /// Defaults to [MethodChannelLyUnityAd].
  static LyUnityAdPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LyUnityAdPlatform] when
  /// they register themselves.
  static set instance(LyUnityAdPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
