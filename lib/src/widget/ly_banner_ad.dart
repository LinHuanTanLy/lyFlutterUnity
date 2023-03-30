import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LyBannerAdWidget extends StatelessWidget {
  const LyBannerAdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AndroidView(
        viewType: "ly_Android_banner",
        creationParamsCodec: StandardMessageCodec(),
    );
  }

}
