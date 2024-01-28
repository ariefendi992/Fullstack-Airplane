import 'package:airplane/shared/base_url.dart';
import 'package:airplane/shared/storage.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioInterceptor extends QueuedInterceptor {
  final Dio dio = Dio();
  final storage = Storage();

  String? _cookie;
  String? accessToken;

  Future<void> getToken() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    accessToken = _pref.getString('access_token');
  }

  @override
  Future<void> onRequest(options, handler) async {
    await getToken();
    options.baseUrl = '$baseUrl/api/v1/';
    options.connectTimeout = Duration(seconds: 5);
    options.receiveTimeout = Duration(seconds: 5);
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    options.headers['Content-Type'] = 'application/json';
    options.headers['Connection'] = 'Keep-Alive';

    super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(Response response, handler) async {
    if (response.statusCode == 200) {
      if (response.headers['set-cookie'] != null) {
        final _saveToken =
            response.headers['set-cookie']![0].split('=')[1].split(';')[0];
        response.headers.add('Connection', 'Keep-Alive');
        await storage.setStorage('access_token', _saveToken.toString());
        saveCookie(_saveToken);
      }
    }
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioException err, handler) async {
    if (err.response?.statusCode == 401) {
      clearAccessToken();
    }
    super.onError(err, handler);
  }

  Future<void> initCookie() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _cookie = _pref.getString('cookie');
  }

  void saveCookie(String newCookie) async {
    if (_cookie != newCookie) {
      _cookie = newCookie;

      SharedPreferences _pref = await SharedPreferences.getInstance();
      _pref.setString('cookie', _cookie!);
    }
  }

  void clearAccessToken() async {
    accessToken = null;
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.remove('access_token');
  }

  void clearCookie() async {
    _cookie = null;
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.remove('cookie');
  }
}
