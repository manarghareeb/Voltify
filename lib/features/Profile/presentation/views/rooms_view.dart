import 'package:flutter/material.dart';
import 'package:voltify/features/Profile/data/room_model.dart';
import 'package:voltify/features/Profile/presentation/views/devicesRoom_view.dart';
import 'package:voltify/features/Profile/presentation/widgets/room_card.dart';
import 'package:voltify/features/const_themes.dart';

class RoomsView extends StatefulWidget {
  const RoomsView({super.key});
  static String routeName = 'rooms';
  @override
  State<RoomsView> createState() => _RoomsViewState();
}

class _RoomsViewState extends State<RoomsView> {
  @override
  Widget build(BuildContext context) {
    final rooms = ModalRoute.of(context)!.settings.arguments as List<RoomModel>;
    return Scaffold(
      backgroundColor: AppTheme.kPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppTheme.kPrimaryColor,
        elevation: 0,
        title: Text(
          "Rooms",
          style: TextStyle(
            color: AppTheme.kSecondaryColor,
            fontSize: ScreenSize.width / 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: ScreenSize.width / 100,
          mainAxisSpacing: ScreenSize.width / 40,
        ),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                DevicesRoomView.routeName,
                arguments: rooms[index],
              );
            },
            child: RoomCardWidget(
              rooms: rooms,
              index: index,
            ),
          );
        },
      ),
    );
  }
}
