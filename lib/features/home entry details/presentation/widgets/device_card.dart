import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voltify/features/const_themes.dart';
import 'package:voltify/features/home%20entry%20details/data/device_model.dart';
import 'package:voltify/features/home%20entry%20details/presentation/cubit/home_design_cubit.dart';

class DeviceCardWidget extends StatelessWidget {
  const DeviceCardWidget(
      {super.key, required this.deviceModel, required this.roomName});
  final DeviceModel deviceModel;
  final String roomName;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Center(
        child: Text(
          "Remove Device",
          style: TextStyle(
            color: Colors.red,
            fontSize: ScreenSize.width / 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      key: UniqueKey(),
      onDismissed: (_) async {
        await BlocProvider.of<HomeDesignCubit>(context)
            .removeDeviceFromFireStoreRooms(
          deviceId: deviceModel.id,
          roomName: roomName,
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          left: ScreenSize.width / 40,
          right: ScreenSize.width / 40,
          top: ScreenSize.width / 40,
          bottom: ScreenSize.width / 40,
        ),
        width: ScreenSize.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              ScreenSize.width / 40,
            ),
            gradient: LinearGradient(
              colors: [
                AppTheme.kSecondaryColor,
                AppTheme.kPrimaryColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: ListTile(
          title: Text(
            deviceModel.deviceName,
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenSize.width / 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            deviceModel.model,
            style: TextStyle(
              color: AppTheme.kSecondaryColor,
              fontSize: ScreenSize.width / 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
