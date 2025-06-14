import 'package:generic_shop_app_api/api.dart';

class GivModelUser {
  GivModelUser({
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

  int? userId;
  String? email;
  String? loyaltyCard;
  int? loyaltyPoints;
  String? loyaltyValue;
  String? currency;
  int? status;
  String? name;
  String? surname;

  factory GivModelUser.fromJson(Map<String, dynamic> json) => GivModelUser(
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

  GsaModelUser toSupportedType() {
    return GsaModelUser(
      id: userId.toString(),
      originId: loyaltyCard,
      username: email,
      personalDetails: GsaModelPerson(
        firstName: name,
        lastName: surname,
      ),
      contact: GsaModelContact(
        email: email,
      ),
      originData: this,
    );
  }
}
