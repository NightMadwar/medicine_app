import 'dart:ffi';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medicine_app/Models/UserModel.dart';
import 'package:medicine_app/Service/AuthService.dart';
import 'package:medicine_app/config/get_it.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<Login>((event, emit) async {
      emit(Loading());
      try {
        dynamic temp = await AuthService().login(UserModel(
          User_Name: event.User_Name,
          Password: event.Password,
        ));
        if (temp != null && temp.data['access_token'] != null) {
          getIt<FlutterSecureStorage>()
              .write(key: "token", value: temp.data['access_token']);
          emit(Success(token: temp.data['access_token']));
        } else {
          emit(Error(error: 'Failed to login.'));
        }
      } catch (e) {
        emit(Error(error: e.toString()));
      }
    });

    on<Register>((event, emit) async {
      emit(Loading());
      try {
        dynamic temp = await AuthService().register(UserModel(
          User_Name: event.user.User_Name,
          Password: event.user.Password,
          Gender: event.user.Gender,
          Email: event.user.Email,
          Height: event.user.Height,
          Age: event.user.Age,
          Weight: event.user.Weight,
          User_Location: event.user.User_Location,
        ));
        if (temp != null && temp.data['access_token'] != null) {
          getIt<FlutterSecureStorage>()
              .write(key: "token", value: temp.data['access_token']);
          emit(Success(token: temp.data['access_token']));
        } else {
          emit(Error(error: 'Failed to register.'));
        }
      } catch (e) {
        emit(Error(error: e.toString()));
      }
    });
  }
}
