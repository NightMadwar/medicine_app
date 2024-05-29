part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class Loading extends AuthState {}

final class Success extends AuthState {
  String token;
  Success({required this.token});
}

final class Error extends AuthState {
  String error;
  Error({required this.error});
}
