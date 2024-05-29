part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class Login extends AuthEvent {
  String User_Name;
  String Password;

  Login({
    required this.User_Name,
    required this.Password,
  });
}

final class Register extends AuthEvent {
  UserModel user;
  Register({required this.user});
}
