import 'package:flutter/material.dart';
import 'package:voltify/features/const_themes.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.txt, required this.onTap});
  final String txt;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      height: ScreenSize.height / 20,
      minWidth: ScreenSize.width / 2,
      color: AppTheme.kSecondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenSize.width / 30),
      ),
      child: Text(
        txt,
        style: TextStyle(
          fontSize: ScreenSize.width / 15,
          fontWeight: FontWeight.bold,
          color: AppTheme.kPrimaryColor,
        ),
      ),
    );
  }
}
