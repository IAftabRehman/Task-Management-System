import 'dart:convert';
UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
// String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? docId;
  final String? subject;
  final String? message;
  final String? userName;
  final int? createdBy;

  UserModel({
    this.docId,
    this.subject,
    this.message,
    this.userName,
    this.createdBy,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    docId: json["docId"],
    subject: json["subject"],
    message: json["message"],
    userName: json["userName"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson(String docId) => {
    "docId": docId,
    "subject": subject,
    "message": message,
    "userName": userName,
    "createdBy": createdBy,
  };
}
