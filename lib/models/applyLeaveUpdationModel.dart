import 'dart:convert';

applyLeaveUpdationModel applyLeaveUpdationModelFromJson(String str) => applyLeaveUpdationModel.fromJson(json.decode(str));

class applyLeaveUpdationModel {
  final String? userName;
  final String? message;
  final String? subject;
  final String? docId;
  final String? status;

  applyLeaveUpdationModel({
    this.userName,
    this.message,
    this.subject,
    this.docId,
    this.status,
  });

  factory applyLeaveUpdationModel.fromJson(Map<String, dynamic> json) => applyLeaveUpdationModel(
    userName: json["userName"],
    message: json["description"],
    subject: json["subject"],
    docId: json["docId"],
    status: json["status"],
  );

  Map<String, dynamic> toJson(String docId) => {
    "userName": userName,
    "description": message,
    "subject": subject,
    "docId": docId,
    "status": status,
  };
}
