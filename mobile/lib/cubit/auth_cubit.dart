import 'package:airplane/models/user_model.dart';
import 'package:airplane/services/user_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signUp(
      {required String email,
      required String password,
      required String name,
      String hobby = ''}) async {
    try {
      emit(AuthLoading());
      final user = await ApiUserService()
          .signUp(email: email, password: password, name: name, hobby: hobby);
      emit(AuthSuccess(user));
    } on DioException catch (e) {
      emit(AuthFailed(e.response?.data['msg']));
    }
  }

  void signIn({required String email, required String password}) async {
    try {
      emit(AuthLoading());

      final user =
          await ApiUserService().signIn(email: email, password: password);

      emit(AuthSuccess(user));
    } on DioException catch (e) {
      emit(AuthFailed(e.response?.data['msg']));
    }
  }

  void currentUser() async {
    try {
      emit(AuthLoading());
      final user = await ApiUserService().currentUser();

      emit(AuthSuccess(user));
    } on DioException catch (e) {
      emit(AuthFailed(e.response?.data['msg']));
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await ApiUserService().signOut();
      emit(AuthInitial());
    } on DioException catch (e) {
      emit(AuthFailed(e.response?.data));
    }
  }
}
