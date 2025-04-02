import 'package:flutter/material.dart';
import 'package:voltify/features/const_themes.dart';

class NextButtonWidget extends StatelessWidget {
  const NextButtonWidget({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onTap,
        color: AppTheme.kSecondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ScreenSize.width / 30,
          ),
        ),
        child: Text(
          "Next",
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenSize.width / 20,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
