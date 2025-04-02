import '../../home entry details/data/device_model.dart';

class DevicesModel {
  final String name;
  final bool isOn;
  final List<DeviceModel> devices;

  DevicesModel({
    required this.name,
    required this.isOn,
    required this.devices,
  });

}
