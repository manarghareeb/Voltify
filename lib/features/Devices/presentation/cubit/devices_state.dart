part of 'devices_cubit.dart';

@immutable
sealed class DevicesState {}

final class DevicesInitial extends DevicesState {}

class DevicesLoading extends DevicesState {}

class DevicesSuccess extends DevicesState {
  final List<DevicesModel> rooms;
  DevicesSuccess(this.rooms);
}

class DevicesError extends DevicesState {
  final String error;
  DevicesError(this.error);
}

