import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int? id;
  final String? email;
  final String? name;
  final String? hobby;
  final int? balance;
  final dynamic additonal;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.hobby = '',
    this.balance = 0,
    this.additonal,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      hobby: json['hobby'],
      balance: json['balance'],
      additonal: json,
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'hobby': hobby,
        'balance': balance,
      };

  @override
  List<Object?> get props => [id, email, name, hobby, balance];
}
