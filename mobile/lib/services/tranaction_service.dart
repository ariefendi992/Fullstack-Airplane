import 'package:airplane/models/transaction_model.dart';
import 'package:airplane/services/interceptor.dart';
import 'package:dio/dio.dart';

class ApiTransactionService {
  final Dio dio = Dio();

  ApiTransactionService() {
    dio.interceptors.add(DioInterceptor());
  }

  Future<void> createTransaction(TransactionModel transaction) async {
    final data = {
      'amountOfTraveler': transaction.amountOfTraveler,
      'selectedSeats': transaction.selectedSeats,
      'insurance': transaction.insurance,
      'refundable': transaction.refundable,
      'vat': transaction.vat,
      'price': transaction.price,
      'grandTotal': transaction.grandTotal,
      'destination_id': transaction.destinationID,
    };

    final resp = await dio.post('/transaction/create', data: data);

    if (resp.statusCode == 200) {
      // TransactionModel transaction = TransactionModel.fromJson(resp.data);
      final transaction = resp.data['msg'];

      return transaction;
    } else {
      throw Exception(resp.data['msg'].toString());
    }
  }

  Future<List<TransactionModel>> fetchTransaction() async {
    final resp = await dio.get('/transaction');
    if (resp.statusCode == 200) {
      final transction = List.from(resp.data['data']).map(
        (e) {
          return TransactionModel.fromJson(e as Map<String, dynamic>);
        },
      ).toList();

      return transction;
    } else {
      throw Exception(resp.data.toString());
    }
  }
}
