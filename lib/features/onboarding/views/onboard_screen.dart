import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:voltify/features/const_themes.dart';
import 'package:voltify/features/onboarding/widgets/onboard_widget.dart';
import 'package:voltify/features/Authentication/presentation/views/login_view.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});
  static String routeName = 'onboard';
  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int index = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  index = value;
                });
              },
              children: const [
                OnboardWidget(
                  image: 'assets/app_images/on1.jpeg',
                  text:
                      "Unlock the power to save money and reduce your carbon footprint with our electricity app, making it easier than ever to track, manage, and optimize your energy consumption.",
                ),
                OnboardWidget(
                  image: "assets/app_images/on2.jpeg",
                  text:
                      "Take control of your energy usage and start saving on your electricity bills today with our app, designed to help you reduce consumption and power your life more efficiently.",
                ),
                OnboardWidget(
                  image: "assets/app_images/on3.jpeg",
                  text:
                      'An electricity app designed to help users save power by tracking energy consumption, providing real-time insights, and offering personalized tips for efficient usage.',
                ),
              ]),
          Positioned(
            bottom: ScreenSize.height / 8,
            child: MaterialButton(
              onPressed: () {
                if (index == 2) {
                  Navigator.pushReplacementNamed(context, LoginView.routeName);
                } else {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.decelerate,
                  );
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ScreenSize.width / 20),
              ),
              color: AppTheme.kSecondaryColor,
              minWidth: ScreenSize.width / 2,
              height: ScreenSize.height / 15,
              child: Text(
                index == 2 ? "Get Started" : "Next",
                style: TextStyle(
                  color: AppTheme.kPrimaryColor,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: ScreenSize.height / 20,
            child: AnimatedSmoothIndicator(
              onDotClicked: (index) {
                controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.decelerate,
                );
              },
              activeIndex: index,
              count: 3,
              effect: WormEffect(
                spacing: ScreenSize.width / 10,
                dotColor: AppTheme.kSecondaryColor,
                paintStyle: PaintingStyle.stroke,
                strokeWidth: 2,
                activeDotColor: AppTheme.kSecondaryColor,
                type: WormType.thin,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
