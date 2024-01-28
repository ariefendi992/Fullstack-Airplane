import 'package:airplane/models/destination_model.dart';
import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  final int? id;
  final int? destinationID;
  final DestinationModel? destination;
  final int? amountOfTraveler;
  final String? selectedSeats;
  final bool? insurance;
  final bool? refundable;
  final double? vat;
  final int? price;
  final int? grandTotal;
  final String? msg;

  TransactionModel({
    this.destination,
    this.id,
    this.amountOfTraveler = 0,
    this.selectedSeats = '',
    this.insurance = false,
    this.refundable = false,
    this.vat = 0,
    this.price = 0,
    this.grandTotal = 0,
    this.destinationID,
    this.msg = '',
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      destination: DestinationModel.fromjson(
        json['destination'],
      ),
      id: json['id'],
      amountOfTraveler: json['amountOfTraveler'],
      selectedSeats: json['selectedSeats'],
      insurance: json['insurance'],
      refundable: json['refundable'],
      vat: json['vat'],
      price: json['price'],
      grandTotal: json['grandTotal'],
      destinationID: json['destination_id'],
      msg: json['msg'],
    );
  }

  @override
  List<Object?> get props => [];
}
