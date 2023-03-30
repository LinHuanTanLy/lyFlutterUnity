import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ly_unity_ad/ly_unity_ad.dart';
import 'package:ly_unity_ad_example/conf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _lyUnityAdPlugin = LyUnityAd();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initCallback();
  }

  void initCallback() {
    _lyUnityAdPlugin.setCallBack((call) {
      switch (call.method) {

      }
      return Future.value(true);
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _lyUnityAdPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Text('Running on: $_platformVersion\n'),
            MaterialButton(
              onPressed: () {
                _lyUnityAdPlugin
                    .init(Conf.androidId, true)
                    .then((value) => debugPrint(value));
              },
              child: const Text("init"),
            ),
            MaterialButton(
              onPressed: () {
                _lyUnityAdPlugin
                    .showInterstitialAd("lyTest", "ly0001")
                    .then((value) => debugPrint('ly say: $value'));
              },
              child: const Text("showInterstitialAd"),
            ),
          ],
        ),
      ),
    );
  }
}
