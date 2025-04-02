import 'package:flutter/material.dart';
import 'package:voltify/features/const_themes.dart';

class AlreadyHaveAccountWidget extends StatelessWidget {
  const AlreadyHaveAccountWidget({
    super.key,
    required this.txt,
    required this.headline,
    required this.onPress,
  });
  final String txt;
  final String headline;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          txt,
          style: TextStyle(
            fontSize: ScreenSize.width / 25,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: onPress,
          child: Text(
            headline,
            style: TextStyle(
              fontSize: ScreenSize.width / 25,
              fontWeight: FontWeight.bold,
              color: AppTheme.kSecondaryColor,
            ),
          ),
        )
      ],
    );
  }
}
