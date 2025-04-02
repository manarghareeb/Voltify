import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:voltify/core/database/cache_helper.dart';
import 'package:voltify/features/const_themes.dart';

class LambaDataWidget extends StatefulWidget {
  const LambaDataWidget({super.key});

  @override
  State<LambaDataWidget> createState() => _LambaDataWidgetState();
}

class _LambaDataWidgetState extends State<LambaDataWidget> {
  int lambaNumber = 1;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(
            ScreenSize.width / 30,
          ),
          margin: EdgeInsets.only(
            top: ScreenSize.height / 25,
            left: ScreenSize.width / 20,
            right: ScreenSize.width / 20,
          ),
          width: ScreenSize.width,
          height: ScreenSize.height / 2.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenSize.width / 20),
            border: Border.all(
              color: AppTheme.kSecondaryColor,
            ),
            gradient: lambaNumber == 2
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                    colors: [
                        AppTheme.kSecondaryColor,
                        AppTheme.kPrimaryColor,
                      ])
                : null,
            boxShadow: [
              lambaNumber == 2
                  ? BoxShadow(
                      color: AppTheme.kSecondaryColor,
                      blurRadius: ScreenSize.width / 5,
                      offset: Offset(0, ScreenSize.height / 15),
                    )
                  : const BoxShadow(
                      color: Colors.transparent,
                    ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email : ${CacheHelper.getData(key: 'email')}",
                style: TextStyle(
                  color: AppTheme.kPrimaryColor,
                  fontSize: ScreenSize.width / 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: ScreenSize.height / 50,
              ),
              Text(
                "Name : ${CacheHelper.getData(key: 'name')}",
                style: TextStyle(
                  color: AppTheme.kPrimaryColor,
                  fontSize: ScreenSize.width / 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: ScreenSize.height / 50,
              ),
              Text(
                "Phone : ${CacheHelper.getData(key: 'phone')}",
                style: TextStyle(
                  color: AppTheme.kPrimaryColor,
                  fontSize: ScreenSize.width / 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: ScreenSize.height / 25,
          child: GestureDetector(
            onTap: () {
              AudioPlayer().play(
                AssetSource('sounds/lamba.mp3'),
              );
              setState(() {
                lambaNumber = lambaNumber == 1 ? 2 : 1;
              });
            },
            child: Image.asset(
              "assets/app_images/lamba $lambaNumber.png",
              height: ScreenSize.height / 8,
            ),
          ),
        ),
      ],
    );
  }
}
