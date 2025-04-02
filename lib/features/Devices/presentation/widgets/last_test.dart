import 'package:flutter/material.dart';
import 'package:voltify/features/Devices/data/devices_model.dart';
import '../../../const_themes.dart';

class RoomItemTest extends StatefulWidget {
  final String roomName;
  //final List<DevicesModel> rooms;
  //final int index;
  RoomItemTest(this.roomName);

  @override
  _RoomItemState createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItemTest> {
  bool showDevices = false;
  late final List<DevicesModel> rooms;
  late final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.kThirdColor,
      child: Column(
        children: [
          ListTile(
            title: Text(
                rooms[index].name,
                style: TextStyle(fontSize: 18, color: Colors.white)
            ),
            trailing: IconButton(
              icon: Icon(showDevices ? Icons.expand_less : Icons.expand_more,
                color: Colors.white,),
              onPressed: () {
                setState(() {
                  showDevices = !showDevices;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}