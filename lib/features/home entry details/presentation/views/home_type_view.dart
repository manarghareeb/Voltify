import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:voltify/features/const_themes.dart';
import 'package:voltify/features/home%20entry%20details/presentation/cubit/home_design_cubit.dart';
import 'package:voltify/features/home%20entry%20details/presentation/views/specific_room_number.dart';
import 'package:voltify/features/home%20entry%20details/presentation/widgets/home_design.dart';
import 'package:voltify/features/home%20entry%20details/presentation/widgets/home_details.dart';
import 'package:voltify/features/home%20entry%20details/presentation/widgets/next_button.dart';

class HomeTypeView extends StatefulWidget {
  const HomeTypeView({super.key});
  static String routeName = 'home-type';
  @override
  State<HomeTypeView> createState() => _HomeTypeViewState();
}

class _HomeTypeViewState extends State<HomeTypeView> {
  Map<String, int> roomCounts = {};
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeDesignCubit, HomeDesignState>(
      listener: (context, state) {
        if (state is GetDevicesSuccess) {
          BlocProvider.of<HomeDesignCubit>(context).nextOne();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SpecificRoomNumberView(
                roomCounts: roomCounts,
              ),
            ),
          );
        } else if (state is GetDevicesError) {
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
          inAsyncCall: state is GetDevicesLoading,
          child: Scaffold(
            backgroundColor: AppTheme.kPrimaryColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Your Home",
                style: TextStyle(
                  color: AppTheme.kSecondaryColor,
                  fontSize: ScreenSize.width / 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: AppTheme.kPrimaryColor,
            ),
            body: Padding(
              padding: EdgeInsets.only(
                left: ScreenSize.width / 30,
                right: ScreenSize.width / 30,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: ScreenSize.height / 40,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        SizedBox(
                          width: ScreenSize.width / 30,
                        ),
                        Text(
                          "Choose your home design",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenSize.width / 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: ScreenSize.height / 50,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child:
                        HomeDesignWidget(), // Wrap HomeDesignWidget if needed
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: ScreenSize.height / 20,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        SizedBox(
                          width: ScreenSize.width / 30,
                        ),
                        Text(
                          "Your Home Details",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenSize.width / 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child:
                        HomeDetails(), // Ensure HomeDetails has proper constraints
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: ScreenSize.height / 30,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: NextButtonWidget(
                      onTap: () async {
                        roomCounts = BlocProvider.of<HomeDesignCubit>(context)
                            .getRoomCounts();
                        log(roomCounts.toString());
                        if (roomCounts.values.any((count) => count > 0)) {
                          if (BlocProvider.of<HomeDesignCubit>(context)
                                  .selectedDesign !=
                              null) {
                            await BlocProvider.of<HomeDesignCubit>(context)
                                .getDevicesAPI();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  'Please select a home design',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                'Please add at least one room',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: ScreenSize.height / 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
