
import 'dart:convert';

LeaveStatusModel leaveStatusModelFromJson(String str) => LeaveStatusModel.fromJson(json.decode(str));

class LeaveStatusModel {
  final String? docId;
  final String? userName;
  final String? status;

  LeaveStatusModel({
    this.docId,
    this.userName,
    this.status,
  });

  factory LeaveStatusModel.fromJson(Map<String, dynamic> json) => LeaveStatusModel(
    docId: json["docId"],
    userName: json["userName"],
    status: json["status"],
  );

  Map<String, dynamic> toJson(String docId) => {
    "docId": docId,
    "userName": userName,
    "status": status,
  };
}
