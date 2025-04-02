part of 'home_design_cubit.dart';

@immutable
sealed class HomeDesignState {}

final class HomeDesignInitial extends HomeDesignState {}
class RoomNumbersUpdated extends HomeDesignState{
  final Map<String, int> roomCounts;
  RoomNumbersUpdated(this.roomCounts);
}
class GetDevicesLoading extends HomeDesignState{}
class GetDevicesSuccess extends HomeDesignState{
  final List<DeviceModel> devices;
  GetDevicesSuccess(this.devices);
}
class GetDevicesError extends HomeDesignState{
  final String error;
  GetDevicesError(this.error);
}
class AddDeviceLoading extends HomeDesignState{}
class AddDeviceSuccess extends HomeDesignState{}
class AddDeviceError extends HomeDesignState{
  final String error;
  AddDeviceError(this.error);
}

class DisplayDevicesSuccess extends HomeDesignState{
  final List<DeviceModel> devices;
  DisplayDevicesSuccess(this.devices);
}
class DisplayDevicesError extends HomeDesignState{
  final String error;
  DisplayDevicesError(this.error);
}

class RemoveDeviceLoading extends HomeDesignState{}
class RemoveDeviceSuccess extends HomeDesignState{}
class RemoveDeviceError extends HomeDesignState{
  final String error;
  RemoveDeviceError(this.error);
}

class UpdateDataUserLoading extends HomeDesignState{}
class UpdateDataUserSuccess extends HomeDesignState{}
class UpdateDataUserError extends HomeDesignState{
  final String error;
  UpdateDataUserError(this.error);
}