import 'package:airplane/models/user_model.dart';
import 'package:airplane/services/interceptor.dart';
import 'package:airplane/shared/storage.dart';
import 'package:dio/dio.dart';

class ApiUserService {
  final Dio dio = Dio();
  ApiUserService() {
    dio.interceptors.add(DioInterceptor());
  }

  Future signUp({
    required String email,
    required String password,
    required String name,
    String hobby = '',
  }) async {
    // UserModel toJson = UserModel.toJson();
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
      'name': name,
      'hobby': hobby,
    };

    final response = await dio.post('/users/create', data: data);

    final body = response.data;
    if (response.statusCode == 201) {
      final user = UserModel.fromJson(body);
      return user;
    } else {
      throw (body['msg']);
    }
  }

  Future<UserModel> signIn(
      {required String email, required String password}) async {
    Map<String, dynamic> data = {'email': email, 'password': password};

    final response = await dio.post('/auth/login', data: data);

    if (response.statusCode == 200) {
      final user = UserModel.fromJson(response.data);
      return user;
    } else {
      throw Exception(response.data['msg'].toString());
    }
  }

  Future<UserModel> currentUser() async {
    final resp = await dio.get('/users/user');

    if (resp.statusCode == 200) {
      final user = UserModel.fromJson(resp.data);

      return user;
    } else {
      throw Exception(resp.data['msg']);
    }
  }

  Future<void> signOut() async {
    final resp = await dio.post('/auth/logout');
    final Storage storage = await Storage();

    if (resp.statusCode == 200) {
      storage.removeStorage('access_token');
    }
  }
}
