import 'package:flutter/material.dart';
import '../../../const_themes.dart';

class RoomItem extends StatefulWidget {
  final String roomName;
  RoomItem(this.roomName);

  @override
  _RoomItemState createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItem> {
  bool showDevices = false;

  final List<Map<String, dynamic>> devices = [
    {"name": "Light", "icon": Icons.lightbulb, "isOn": false},
    {"name": "Fan", "icon": Icons.air, "isOn": true},
    {"name": "TV", "icon": Icons.tv, "isOn": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.kThirdColor,
      child: Column(
        children: [
          ListTile(
            title: Text(
                widget.roomName,
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
          if (showDevices)
            Column(
              children: devices.map((device) {
                return ListTile(
                  leading: Icon(device["icon"], size: 30, color: Colors.white,),
                  title: Text(device["name"], style: TextStyle(fontSize: 16,color: Colors.white)),
                  trailing: Switch(
                    value: device["isOn"],
                    activeColor: AppTheme.kSecondaryColor,
                    onChanged: (value) {
                      setState(() {
                        device["isOn"] = value;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}