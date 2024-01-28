part of 'destination_cubit.dart';

class DestinationState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DestinationInitial extends DestinationState {}

class DestinationLoading extends DestinationState {}

class DestinationSuccess extends DestinationState {
  final List<DestinationModel> destniations;

  DestinationSuccess(this.destniations);

  @override
  List<Object> get props => [destniations];
}

class DestinationFailed extends DestinationState {
  final String error;

  DestinationFailed(this.error);

  @override
  List<Object> get props => [error];
}
