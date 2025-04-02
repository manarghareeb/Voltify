import 'package:flutter/material.dart';
import 'package:voltify/features/const_themes.dart';

class OnboardWidget extends StatelessWidget {
  const OnboardWidget({super.key, required this.image, required this.text});
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    ScreenSize.intial(context);
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background image
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: ScreenSize.height / 1.7,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Positioned container over the image
          Positioned(
            bottom: -ScreenSize.height / 2, // Adjust as needed
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: ScreenSize.height / 1.8, // Adjust height as needed
              decoration: BoxDecoration(
                color: AppTheme.kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ScreenSize.width / 10),
                  topRight: Radius.circular(ScreenSize.width / 10),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: ScreenSize.height / 15,
                  ),
                  SizedBox(
                    width: ScreenSize.width / 1.2,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenSize.width / 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
