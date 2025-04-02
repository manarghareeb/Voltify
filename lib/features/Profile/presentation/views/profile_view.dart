import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:voltify/features/Profile/presentation/cubit/profile_cubit.dart';
import 'package:voltify/features/Profile/presentation/views/rooms_view.dart';
import 'package:voltify/features/Profile/presentation/widgets/lamba_data_widget.dart';
import 'package:voltify/features/const_themes.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  static String routeName = 'profile';
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int lambaNumber = 1;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is GetRoomsSuccess) {
          Navigator.pushNamed(context, RoomsView.routeName,
              arguments: state.rooms);
        } else if (state is GetRoomsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is GetRoomsLoading,
          child: Scaffold(
              backgroundColor: AppTheme.kPrimaryColor,
              appBar: AppBar(
                title: Text(
                  "Profile",
                  style: TextStyle(
                    color: AppTheme.kSecondaryColor,
                    fontSize: ScreenSize.width / 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                backgroundColor: AppTheme.kPrimaryColor,
                elevation: 0,
              ),
              body: Column(
                children: [
                  const LambaDataWidget(),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenSize.height / 30,
                    ),
                    child: Text(
                      "Go to Rooms in your home",
                      style: TextStyle(
                        color: AppTheme.kSecondaryColor,
                        fontSize: ScreenSize.width / 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future:
                        BlocProvider.of<ProfileCubit>(context).getHomeDesign(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        return GestureDetector(
                          onTap: () {
                            //   Navigator.pushNamed(context, RoomsView.routeName);
                            BlocProvider.of<ProfileCubit>(context).getRooms();
                          },
                          child: Image.network(
                            snapshot.data!,
                            height: ScreenSize.height / 4,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
              )),
        );
      },
    );
  }
}
