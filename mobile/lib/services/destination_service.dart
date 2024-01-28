import 'package:airplane/models/destination_model.dart';
import 'package:airplane/services/interceptor.dart';
import 'package:dio/dio.dart';

class APiDestinationService {
  final Dio dio = Dio();

  APiDestinationService() {
    dio.interceptors.add(DioInterceptor());
  }

  Future<List<DestinationModel>> destinations() async {
    final resp = await dio.get('/destination/');

    if (resp.statusCode == 200) {
      final destination = List.from(resp.data['data'])
          .map((e) => DestinationModel.fromjson(e))
          .toList();

      return destination;
    } else {
      throw Exception(resp.data['msg'].toString());
    }
  }
}
