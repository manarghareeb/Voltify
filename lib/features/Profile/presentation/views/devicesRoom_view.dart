import 'package:flutter/material.dart';
import 'package:voltify/features/Profile/data/room_model.dart';
import 'package:voltify/features/const_themes.dart';

class DevicesRoomView extends StatefulWidget {
  const DevicesRoomView({super.key});
  static String routeName = 'DevicesRoomView';
  @override
  State<DevicesRoomView> createState() => _DevicesRoomViewState();
}

class _DevicesRoomViewState extends State<DevicesRoomView> {
  @override
  Widget build(BuildContext context) {
    final room = ModalRoute.of(context)!.settings.arguments as RoomModel;
    return Scaffold(
      backgroundColor: AppTheme.kPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppTheme.kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          room.name,
          style: TextStyle(
            color: AppTheme.kSecondaryColor,
            fontSize: ScreenSize.width / 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: AppTheme.kSecondaryColor,
      //   child: Icon(
      //     Icons.add,
      //     size: ScreenSize.width / 10,
      //     color: Colors.black,
      //   ),
      // ),
      body: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: ScreenSize.width / 10,
            mainAxisSpacing: ScreenSize.width / 10,
          ),
          itemCount: room.devices.length,
          itemBuilder: (context, index) {
            return Stack(children: [
              Container(
                padding: EdgeInsets.only(
                  left: ScreenSize.width / 40,
                  right: ScreenSize.width / 40,
                ),
                margin: EdgeInsets.only(
                  left: ScreenSize.width / 40,
                  right: ScreenSize.width / 40,
                  top: ScreenSize.width / 40,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenSize.width / 30),
                  color: AppTheme.kSecondaryColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: ScreenSize.width / 3,
                      height: ScreenSize.width / 4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            room.devices[index].deviceIcon,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      room.devices[index].deviceName,
                      style: TextStyle(
                        color: AppTheme.kPrimaryColor,
                        fontSize: ScreenSize.width / 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      room.devices[index].model,
                      style: TextStyle(
                        color: AppTheme.kPrimaryColor,
                        fontSize: ScreenSize.width / 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      indent: ScreenSize.width / 10,
                      endIndent: ScreenSize.width / 10,
                      color: AppTheme.kPrimaryColor,
                    ),
                    Text(
                      "PowerConsumption (W/H) watt per hour is ${room.devices[index].powerConsumption} W",
                      style: TextStyle(
                        color: AppTheme.kPrimaryColor,
                        fontSize: ScreenSize.width / 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // IconButton(
              //   onPressed: () {
              //     setState(() {
              //       context.read<ProfileCubit>().removeDeviceFromFireStoreRooms(
              //           deviceId: room.devices[index].id, roomName: room.name);
              //     });
              //   },
              //   style: IconButton.styleFrom(
              //     shape: const CircleBorder(),
              //     backgroundColor: Colors.red,
              //   ),
              //   icon: Icon(
              //     Icons.delete,
              //     color: Colors.white,
              //     size: ScreenSize.width / 15,
              //   ),
              // ),
            ]);
          }),
    );
  }
}
