import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ly_unity_ad/ly_unity_ad_method_channel.dart';

void main() {
  MethodChannelLyUnityAd platform = MethodChannelLyUnityAd();
  const MethodChannel channel = MethodChannel('ly_unity_ad');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
