import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voltify/features/const_themes.dart';
import 'package:voltify/features/home%20entry%20details/data/device_model.dart';
import 'package:voltify/features/home%20entry%20details/presentation/cubit/home_design_cubit.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent(
      {super.key,
      required this.devices,
      required this.roomName,
      required this.roomNumber});
  final List<DeviceModel> devices;
  final String roomName;
  final int roomNumber;
  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  String? dropdownValue1;
  String? dropdownValue2;

  Set<String> devicesName = {};
  List<String> filteredModels = [];

  @override
  void initState() {
    devicesName = widget.devices.map((device) => device.deviceName).toSet();
    super.initState();
  }

  void updateModels(String? selectedDevice) {
    if (selectedDevice != null) {
      setState(() {
        filteredModels = widget.devices
            .where((device) => device.deviceName == selectedDevice)
            .map((device) => device.model)
            .toList();
        dropdownValue2 = null; // Reset the second dropdown
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ScreenSize.width / 30),
      child: BlocConsumer<HomeDesignCubit, HomeDesignState>(
        listener: (context, state) async {
          if (state is AddDeviceSuccess) {
          
            Navigator.pop(context);
          }
          if (state is AddDeviceError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  state.error,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New Device to your Room',
                style: TextStyle(
                  fontSize: ScreenSize.width / 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: ScreenSize.height / 40,
              ),
              DropdownButton<String>(
                focusColor: AppTheme.kSecondaryColor,
                dropdownColor: AppTheme.kPrimaryColor,
                isExpanded: true,
                value: dropdownValue1,
                hint: Text(
                  'Select a Device name',
                  style: TextStyle(
                    color: AppTheme.kSecondaryColor,
                  ),
                ),
                items: devicesName.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: AppTheme.kSecondaryColor,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    dropdownValue1 = newValue;
                  });
                  updateModels(newValue);
                },
              ),
              SizedBox(
                height: ScreenSize.height / 40,
              ),
              DropdownButton<String>(
                focusColor: AppTheme.kSecondaryColor,
                dropdownColor: AppTheme.kPrimaryColor,
                isExpanded: true,
                value: dropdownValue2,
                hint: Text(
                  'Select a Device model',
                  style: TextStyle(
                    color: AppTheme.kSecondaryColor,
                  ),
                ),
                items: filteredModels.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: AppTheme.kSecondaryColor,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    dropdownValue2 = newValue;
                  });
                },
              ),
              SizedBox(
                height: ScreenSize.height / 40,
              ),
              Align(
                alignment: Alignment.center,
                child: state is AddDeviceLoading
                    ? CircularProgressIndicator(
                        color: AppTheme.kSecondaryColor,
                      )
                    : ElevatedButton(
                        onPressed: () {
                          if (dropdownValue1 != null &&
                              dropdownValue2 != null) {
                            context
                                .read<HomeDesignCubit>()
                                .addDeviceToFireStoreRooms(
                                  roomName:
                                      '${widget.roomName} ${widget.roomNumber}',
                                  deviceName: dropdownValue1!,
                                  model: dropdownValue2!,
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.kSecondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              ScreenSize.width / 30,
                            ),
                          ),
                          minimumSize: Size(
                            ScreenSize.width / 3,
                            ScreenSize.height / 20,
                          ),
                        ),
                        child: Text(
                          'Add Device',
                          style: TextStyle(
                            color: AppTheme.kPrimaryColor,
                            fontSize: ScreenSize.width / 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: ScreenSize.height / 20,
              ),
            ],
          );
        },
      ),
    );
  }
}
