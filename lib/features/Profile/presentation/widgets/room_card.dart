import 'package:flutter/material.dart';
import 'package:voltify/features/Profile/data/room_model.dart';
import 'package:voltify/features/const_themes.dart';

class RoomCardWidget extends StatelessWidget {
  const RoomCardWidget({super.key, required this.rooms, required this.index});
final List<RoomModel> rooms;
final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(
              left: ScreenSize.width / 40,
              right: ScreenSize.width / 40,
              top: ScreenSize.width / 40,
              bottom: ScreenSize.width / 40,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenSize.width / 30),
              border: Border.all(
                color: AppTheme.kSecondaryColor,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Text(
                  rooms[index].name,
                  style: TextStyle(
                    color: AppTheme.kSecondaryColor,
                    fontSize: ScreenSize.width / 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: ScreenSize.width / 2.3,
                  height: ScreenSize.width / 2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(rooms[index].image),
                    ),
                  ),
                ),
                Text("${rooms[index].devices.length} Devices",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenSize.width / 30,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          );
  }
}