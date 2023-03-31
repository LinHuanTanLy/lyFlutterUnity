import 'package:flutter/material.dart';
import 'package:ly_unity_ad/ly_unity_ad.dart';

class BannerAdExample extends StatelessWidget {
  const BannerAdExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(width: 750, height: 100, child: LyBannerAdWidget()),
        const SizedBox(width: 750, height: 100, child: LyBannerAdWidget()),
      ],
    );
  }
}
