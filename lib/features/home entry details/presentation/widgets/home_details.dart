import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voltify/features/const_themes.dart';
import 'package:voltify/features/home%20entry%20details/presentation/cubit/home_design_cubit.dart';
import 'package:voltify/features/home%20entry%20details/presentation/widgets/room_amount.dart';

class HomeDetails extends StatefulWidget {
  const HomeDetails({super.key});

  @override
  State<HomeDetails> createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  List<String> roomsname = [
    "Living Room",
    "Bedroom",
    "Kitchen",
    "Bathroom",
    "Office",
    "Laundary Room",
    "Storage Room",
    "Balcony"
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: roomsname.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoomAmountWidget(
                roomName: roomsname[index],
                onpluss: () {
                  BlocProvider.of<HomeDesignCubit>(context).addRoomNumbers(
                    roomsname[index],
                  );
                  setState(() {});
                },
                onminus: () {
                  BlocProvider.of<HomeDesignCubit>(context).removeRoomNumbers(
                    roomsname[index],
                  );
                  setState(() {});
                },
              ),
              index == roomsname.length - 1
                  ? const SizedBox()
                  : Divider(
                      indent: ScreenSize.width / 10,
                      endIndent: ScreenSize.width / 10,
                      color: Colors.black,
                      thickness: 0.5,
                    ),
            ],
          );
        });
  }
}
