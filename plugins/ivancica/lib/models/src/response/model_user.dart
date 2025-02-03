import 'dart:convert';

import 'package:generic_shop_app_api/generic_shop_app_api.dart';

class GivModelUser {
  int? statusResponse;
  int? userId;
  String? email;
  String? loyaltyCard;
  int? loyaltyPoints;
  String? loyaltyValue;
  String? currency;
  int? status;
  String? name;
  String? surname;

  GivModelUser({
    this.statusResponse,
    this.userId,
    this.email,
    this.loyaltyCard,
    this.loyaltyPoints,
    this.loyaltyValue,
    this.currency,
    this.status,
    this.name,
    this.surname,
  });

  factory GivModelUser.fromJson(Map<String, dynamic> json) => GivModelUser(
        statusResponse: json['statusResponse'],
        userId: json['userId'],
        email: json['email'],
        loyaltyCard: json['loyaltyCard'],
        loyaltyPoints: json['loyaltyPoints'],
        loyaltyValue: json['loyaltyValue'],
        currency: json['currency'],
        status: json['status'],
        name: json['name'],
        surname: json['surname'],
      );

  Map<String, dynamic> toJson() => {
        'statusResponse': statusResponse,
        'userId': userId,
        'email': email,
        'loyaltyCard': loyaltyCard,
        'loyaltyPoints': loyaltyPoints,
        'loyaltyValue': loyaltyValue,
        'currency': currency,
        'status': status,
        'name': name,
        'surname': surname,
      };

  GsaaModelUser toSupportedType() {
    return GsaaModelUser(
      id: userId.toString(),
      originId: loyaltyCard,
      username: email,
      personalDetails: GsaaModelPerson(
        firstName: name,
        lastName: surname,
      ),
    );
  }
}
