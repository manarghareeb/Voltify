import 'package:flutter/material.dart';
import 'package:voltify/features/const_themes.dart';

class EnergyView extends StatefulWidget {
  const EnergyView({super.key});
  static String routeName = 'energy';
  @override
  State<EnergyView> createState() => _EnergyViewState();
}

class _EnergyViewState extends State<EnergyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kPrimaryColor,
      body: Stack(alignment: Alignment.center, children: [
        Placeholder(),
        Text(
          "SOON...",
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenSize.width / 15,
          ),
        ),
      ]),
    );
  }
}
