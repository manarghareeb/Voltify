import 'package:flutter/material.dart';
import 'package:voltify/features/const_themes.dart';

class CircleShadowIcon extends StatelessWidget {
  const CircleShadowIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            SizedBox(
              width: ScreenSize.width,
              height: ScreenSize.height / 4,
            ),
            Positioned(
              top: -ScreenSize.height / 80,
              right: -ScreenSize.width / 30,
              child: Image.asset(
                "assets/app_images/circle.png",
              ),
            ),
            Positioned(
              top: -ScreenSize.height / 70,
              right: -ScreenSize.width / 15,
              child: Image.asset(
                "assets/app_images/c shadow.png",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
