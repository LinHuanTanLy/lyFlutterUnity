import 'package:flutter_test/flutter_test.dart';
import 'package:ly_unity_ad/ly_unity_ad.dart';
import 'package:ly_unity_ad/ly_unity_ad_platform_interface.dart';
import 'package:ly_unity_ad/ly_unity_ad_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLyUnityAdPlatform
    with MockPlatformInterfaceMixin
    implements LyUnityAdPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LyUnityAdPlatform initialPlatform = LyUnityAdPlatform.instance;

  test('$MethodChannelLyUnityAd is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLyUnityAd>());
  });

  test('getPlatformVersion', () async {
    LyUnityAd lyUnityAdPlugin = LyUnityAd();
    MockLyUnityAdPlatform fakePlatform = MockLyUnityAdPlatform();
    LyUnityAdPlatform.instance = fakePlatform;

    expect(await lyUnityAdPlugin.getPlatformVersion(), '42');
  });
}
