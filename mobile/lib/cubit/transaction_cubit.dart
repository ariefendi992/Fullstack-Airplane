import 'package:airplane/models/transaction_model.dart';
import 'package:airplane/services/tranaction_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  void createTransaction(TransactionModel transaction) async {
    try {
      emit(TransactionLoading());
      await ApiTransactionService().createTransaction(transaction);
      emit(TransactionSuccess([]));
    } on DioException catch (e) {
      emit(TransactionFailed(e.response?.data));
    }
  }

  void fetchTransaction() async {
    try {
      emit(TransactionLoading());
      List<TransactionModel> transactions =
          await ApiTransactionService().fetchTransaction();

      emit(TransactionSuccess(transactions));
    } on DioException catch (e) {
      emit(TransactionFailed(e.response?.data['msg']));
    }
  }
}
