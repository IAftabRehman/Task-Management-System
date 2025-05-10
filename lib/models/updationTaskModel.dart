import 'dart:convert';

UpdationTaskModel updationTaskModelFromJson(String str) =>
    UpdationTaskModel.fromJson(json.decode(str));

class UpdationTaskModel {
  final String? userName;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? docId;
  final String? status;

  UpdationTaskModel({
    this.userName,
    this.description,
    this.startDate,
    this.endDate,
    this.docId,
    this.status,
  });

  factory UpdationTaskModel.fromJson(Map<String, dynamic> json) =>
      UpdationTaskModel(
        userName: json["userName"],
        description: json["description"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        docId: json["docId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson(String? docId) => {
    "userName": userName,
    "description": description,
    "startDate": startDate,
    "endDate": endDate,
    "docId": docId,
    "status": status,
  };
}
