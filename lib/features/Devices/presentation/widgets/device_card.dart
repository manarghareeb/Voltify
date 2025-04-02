import 'package:flutter/material.dart';
import 'package:voltify/features/Devices/data/devices_model.dart';
import '../../../const_themes.dart';

class DeviceListWidget extends StatefulWidget {
  final List<DevicesModel> devices;
  final bool showDevices;
  final Function(bool) onSwitchChanged;
  final String roomName;

  const DeviceListWidget({
    Key? key,
    required this.devices,
    required this.showDevices,
    required this.onSwitchChanged,
    required this.roomName,
  }) : super(key: key);

  @override
  State<DeviceListWidget> createState() => _DeviceListWidgetState();
}

class _DeviceListWidgetState extends State<DeviceListWidget> {
  bool showDevices = false;
  bool isOn = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.kThirdColor,
      child: Column(
        children: [
          ListTile(
            title: Text(
                widget.roomName,
                style: const TextStyle(fontSize: 18, color: Colors.white)
            ),
            trailing: IconButton(
              icon: Icon(widget.showDevices ? Icons.expand_less : Icons.expand_more,
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
              children: widget.devices.map((device) {
                return ListTile(
                  leading: Icon(Icons.light, size: 30, color: Colors.white,),
                  title: Text("device[""]", style: TextStyle(fontSize: 16,color: Colors.white)),
                  trailing: Switch(
                    value: isOn,
                    activeColor: AppTheme.kSecondaryColor,
                    onChanged: (value) {
                      setState(() {
                        isOn = value;
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
