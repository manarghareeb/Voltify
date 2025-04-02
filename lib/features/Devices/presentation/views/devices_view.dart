import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../const_themes.dart';
import '../cubit/devices_cubit.dart';
import '../widgets/device_card.dart';

class DevicesView extends StatefulWidget {
  const DevicesView({super.key});
  static String routeName = 'devices';
  @override
  State<DevicesView> createState() => _DevicesViewState();
}

class _DevicesViewState extends State<DevicesView> {
  bool light = true;
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<DevicesCubit, DevicesState>(
        listener: (context, state) {
          if (state is DevicesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red
              ),
            );
          }
          },
        builder: (context, state) {
          return ModalProgressHUD(
              inAsyncCall: state is DevicesLoading,
              child: Scaffold(
                backgroundColor: AppTheme.kPrimaryColor,
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
                        child: state is DevicesSuccess
                            ? ListView.builder(
                          itemCount: state.rooms.length,
                          itemBuilder: (context, index) {
                            return DeviceListWidget(
                              devices: [],//state.rooms[index].devices,
                              roomName: state.rooms[index].name,
                              onSwitchChanged: (bool value) {
                                setState(() {
                                  light = value;
                                });
                              }, showDevices: false,
                            );
                          },
                        )
                            : const Center(
                          child: Text(
                            'No devices found.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )

                                          ],
                  ),
                ),
              )
          );
        }
        );


  }
}


