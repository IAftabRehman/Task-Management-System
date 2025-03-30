import 'dart:convert';
RegistrationModel registrationModelFromJson(String str) => RegistrationModel.fromJson(json.decode(str));
// String registrationModelToJson(RegistrationModel data) => json.encode(data.toJson());

class RegistrationModel {
  final String? name;
  final String? gender;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final String? docId;
  final int? createdAt;

  RegistrationModel({
    this.name,
    this.gender,
    this.email,
    this.password,
    this.phoneNumber,
    this.docId,
    this.createdAt,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
    name: json["name"],
    gender: json["gender"],
    email: json["email"],
    password: json["password"],
    phoneNumber: json["phoneNumber"],
    docId: json["docId"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String docId) => {
    "name": name,
    "gender": gender,
    "email": email,
    "password": password,
    "phoneNumber": phoneNumber,
    "docId": docId,
    "createdAt": createdAt,
  };
}
