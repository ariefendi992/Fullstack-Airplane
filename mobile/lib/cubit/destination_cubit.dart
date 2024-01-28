import 'package:airplane/models/destination_model.dart';
import 'package:airplane/services/destination_service.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'destination_state.dart';

class DestinationCubit extends Cubit<DestinationState> {
  DestinationCubit() : super(DestinationInitial());

  void fetchDestination() async {
    try {
      emit(DestinationLoading());
      final List<DestinationModel> destionation =
          await APiDestinationService().destinations();

      emit(DestinationSuccess(destionation));
    } on DioException catch (e) {
      emit(e.response?.data['msg']);
    }
  }
}
