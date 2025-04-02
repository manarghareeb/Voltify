import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voltify/features/const_themes.dart';
import 'package:voltify/features/home%20entry%20details/data/device_model.dart';
import 'package:voltify/features/home%20entry%20details/presentation/cubit/home_design_cubit.dart';
import 'package:voltify/features/home%20entry%20details/presentation/widgets/buttom_sheet.dart';
import 'package:voltify/features/home%20entry%20details/presentation/widgets/device_card.dart';

class RoomPage extends StatefulWidget {
  final String roomName;
  final int roomNumber;

  const RoomPage({required this.roomName, required this.roomNumber, super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppTheme.kPrimaryColor,
        title: Text(
          '${widget.roomName} ${widget.roomNumber}',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenSize.width / 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              fit: BoxFit.fill,
              widget.roomName == "Bedroom"
                  ? "assets/app_images/rooms/bedRoom.png"
                  : widget.roomName == "Kitchen"
                      ? "assets/app_images/rooms/kitchen.png"
                      : widget.roomName == "Living Room"
                          ? "assets/app_images/rooms/livingRoom.png"
                          : widget.roomName == "Bathroom"
                              ? "assets/app_images/rooms/bathRoom.png"
                              : widget.roomName == "Office"
                                  ? "assets/app_images/rooms/Office.png"
                                  : widget.roomName == "Laundary Room"
                                      ? "assets/app_images/rooms/Laundary Room.png"
                                      : widget.roomName == "Storage Room"
                                          ? "assets/app_images/rooms/Storage Room.png"
                                          : "assets/app_images/rooms/Balcony.png",
            ),
            Row(
              children: [
                SizedBox(
                  width: ScreenSize.width / 30,
                ),
                FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled:
                          true, // Optional: Adjust this based on your content
                      backgroundColor: AppTheme
                          .kPrimaryColor, // Optional: Set background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(ScreenSize.width / 30),
                        ),
                      ),
                      builder: (context) => BottomSheetContent(
                        roomName: widget.roomName,
                        roomNumber: widget.roomNumber,
                        devices: BlocProvider.of<HomeDesignCubit>(context)
                            .devicesAPI,
                      ),
                    );
                  },
                  backgroundColor: AppTheme.kSecondaryColor,
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: ScreenSize.width / 5,
                ),
                Text(
                  "Devices",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenSize.width / 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.white,
              indent: ScreenSize.width / 4,
              endIndent: ScreenSize.width / 4,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: BlocProvider.of<HomeDesignCubit>(context)
                  .displayDevicesFromSpecificRoom(
                      '${widget.roomName} ${widget.roomNumber}'),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  // Display an error message
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator while waiting
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.kSecondaryColor,
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  // Display a message if no data is available
                  return const Center(
                    child: Text(
                      'No devices right now !',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                // If data is available, display it in a ListView
                var devices = snapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Prevents conflicts with parent scroll
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    var device = devices[index].data() as Map<String, dynamic>;
                    return DeviceCardWidget(
                      roomName: '${widget.roomName} ${widget.roomNumber}',
                      deviceModel: DeviceModel(
                        id: device['id'],
                        deviceName: device['deviceName'],
                        model: device['model'],
                        deviceIcon: device['deviceIcon'],
                        powerConsumption: device['powerConsumption'],
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(
              height: ScreenSize.height / 30,
            ),
          ],
        ),
      ),
    );
  }
}
