part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {}

class SignUpError extends AuthState {
  final String message;
  SignUpError(this.message);
}

class SignInLoading extends AuthState {}

class SignInSuccess extends AuthState {}

class SignInError extends AuthState {
  final String message;
  SignInError(this.message);
}
