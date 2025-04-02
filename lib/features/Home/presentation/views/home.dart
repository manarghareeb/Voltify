import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:voltify/features/Devices/presentation/views/devices_view.dart';
import 'package:voltify/features/Energy/presentation/views/energy_view.dart';
import 'package:voltify/features/Home/presentation/views/home_view.dart';
import 'package:voltify/features/Profile/presentation/views/profile_view.dart';
import 'package:voltify/features/const_themes.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});
static const String routeName = 'home';
  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  int bottomNavIndex = 0;
  List<Widget> screens = [
    const HomeView(),
    const EnergyView(),
    const DevicesView(),
    const ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kPrimaryColor,
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: AppTheme.kThirdColor,
        selectedIndex: bottomNavIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          bottomNavIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: const Icon(
              FontAwesomeIcons.house,
              color: Colors.white,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: AppTheme.kSecondaryColor,
                fontSize: ScreenSize.width / 22,
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: const Icon(
              FontAwesomeIcons.bolt,
              color: Colors.white,
            ),
            title: Text(
              'Energy',
              style: TextStyle(
                color: AppTheme.kSecondaryColor,
                fontSize: ScreenSize.width / 22,
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: const Icon(
              FontAwesomeIcons.plug,
              color: Colors.white,
            ),
            title: Text(
              'Devices',
              style: TextStyle(
                color: AppTheme.kSecondaryColor,
                fontSize: ScreenSize.width / 22,
              ),
            ),
          ),
          FlashyTabBarItem(
            icon: const Icon(
              FontAwesomeIcons.user,
              color: Colors.white,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                color: AppTheme.kSecondaryColor,
                fontSize: ScreenSize.width / 22,
              ),
            ),
          ),
        ],
      ),
      body: screens[bottomNavIndex],
    );
  }
}
