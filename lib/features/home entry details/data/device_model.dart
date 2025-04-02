class DeviceModel {
  final String deviceName;
  final num powerConsumption;
  final String model;
  final String id;
  final String deviceIcon;
  DeviceModel({
    required this.deviceIcon,
    required this.deviceName,
    required this.id,
    required this.powerConsumption,
    required this.model,
  });
  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      deviceIcon: json['DeviceIcon'],
      deviceName: json['DeviceName'],
      id: json['_id'],
      powerConsumption: json['PowerConsumption'],
      model: json['Model'],
    );
  }
  factory DeviceModel.fromFireStore(Map<String, dynamic> map) {
    return DeviceModel(
      deviceIcon: map['deviceIcon'],
      deviceName: map['deviceName'],
      id: map['id'],
      powerConsumption: map['powerConsumption'],
      model: map['model'],
    );
  }
}
