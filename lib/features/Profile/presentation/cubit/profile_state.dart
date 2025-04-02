part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class GetRoomsLoading extends ProfileState {}

class GetRoomsSuccess extends ProfileState {
  final List<RoomModel> rooms;
  GetRoomsSuccess(this.rooms);
}

class GetRoomsError extends ProfileState {
  final String error;
  GetRoomsError(this.error);
}

class RemoveDeviceLoading extends ProfileState {}

class RemoveDeviceSuccess extends ProfileState {}

class RemoveDeviceError extends ProfileState {
  final String error;
  RemoveDeviceError(this.error);
}
