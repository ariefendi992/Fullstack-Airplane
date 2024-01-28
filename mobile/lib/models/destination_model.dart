import 'package:equatable/equatable.dart';

class DestinationModel extends Equatable {
  final int? id;
  final String imgUrl;
  final String name;
  final String city;
  final double rating;
  final int? price;
  final bool? isNew;
  final bool? isPopular;

  const DestinationModel({
    required this.id,
    required this.imgUrl,
    required this.name,
    required this.city,
    required this.rating,
    this.price,
    this.isNew,
    this.isPopular,
  });

  factory DestinationModel.fromjson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id'],
      imgUrl: json['imgUrl'],
      name: json['name'],
      city: json['city'],
      rating: json['rating'],
      price: json['price'],
      isNew: json['isNew'],
      isPopular: json['isPopular'],
    );
  }
  @override
  List<Object?> get props =>
      [id, imgUrl, name, city, rating, price, isNew, isPopular];
}
