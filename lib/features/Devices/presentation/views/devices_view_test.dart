import 'package:flutter/material.dart';
import '../../../const_themes.dart';
import '../widgets/devices_card_test.dart';

class DeviceScreen extends StatelessWidget {
  final List<String> rooms = ['Living Room', 'Bedroom', 'Kitchen'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Devices',
          style: TextStyle(
            color: AppTheme.kSecondaryColor,
            fontSize: MediaQuery.of(context).size.width / 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.kPrimaryColor,
        elevation: 0,
      ),
      backgroundColor: AppTheme.kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your devices:',
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width / 22,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width / 20),
            Expanded(
              child: ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  return RoomItem(rooms[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
