import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:voltify/features/Authentication/presentation/views/login_view.dart';
import 'package:voltify/features/Authentication/presentation/widgets/button_widget.dart';
import 'package:voltify/features/const_themes.dart';
import 'package:voltify/features/home%20entry%20details/presentation/cubit/home_design_cubit.dart';
import 'package:voltify/features/home%20entry%20details/presentation/widgets/room_page.dart';

class SpecificRoomNumberView extends StatefulWidget {
  const SpecificRoomNumberView({super.key, required this.roomCounts});
  static String routeName = 'SpecificRoomNumberView';
  final Map<String, int> roomCounts;

  @override
  State<SpecificRoomNumberView> createState() => _SpecificRoomNumberViewState();
}

class _SpecificRoomNumberViewState extends State<SpecificRoomNumberView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pages = [];

    widget.roomCounts.forEach((roomName, count) {
      for (int i = 1; i <= count; i++) {
        pages.add({
          'roomName': roomName,
          'roomNumber': i,
        });
      }
    });

    return Scaffold(
      backgroundColor: AppTheme.kPrimaryColor,
      body: Stack(
        children: [
          PageView.builder(
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemCount:
                pages.length + 1, // Add an extra page for the "Finish" button
            itemBuilder: (context, index) {
              if (index == pages.length) {
                // Last page with Finish button
                return BlocConsumer<HomeDesignCubit, HomeDesignState>(
                  listener: (context, state) {
                    if (state is UpdateDataUserSuccess) {
                      FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                      Navigator.pushReplacementNamed(
                        context,
                        LoginView.routeName,
                      );
                    } else if (state is UpdateDataUserError) {
                      StylishDialog(
                        alertType: StylishDialogType.ERROR,
                        context: context,
                        title: Text("Error"),
                        content: Text(state.error),
                      ).show();
                    }
                  },
                  builder: (context, state) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/app_images/finish.gif",
                            height: ScreenSize.height / 3,
                          ),
                          SizedBox(
                            width: ScreenSize.width / 1.1,
                            child: Text(
                                '''You have successfully added all devices to their respective rooms. Your setup is now complete. If you wish to make changes, you can revisit any room or add more devices later.
                                      
                 Thank you for completing the process. You can now manage and monitor your,''',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppTheme.kFontStyle1,
                                  fontSize: ScreenSize.width / 25,
                                )),
                          ),
                          state is UpdateDataUserLoading
                              ? CircularProgressIndicator(
                                  color: AppTheme.kSecondaryColor,
                                )
                              : CustomButton(
                                  txt: "Finish",
                                  onTap: () {
                                    context
                                        .read<HomeDesignCubit>()
                                        .finishButton();
                                  },
                                ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                final page = pages[index];
                return RoomPage(
                  roomName: page['roomName'],
                  roomNumber: page['roomNumber'],
                );
              }
            },
          ),
          // Optional progress indicator for better UX
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: LinearProgressIndicator(
              value: (currentIndex + 1) / (pages.length + 1),
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
