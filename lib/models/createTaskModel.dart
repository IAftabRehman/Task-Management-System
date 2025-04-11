import 'dart:convert';

CreateTaskModel createTaskModelFromJson(String str) => CreateTaskModel.fromJson(json.decode(str));


class CreateTaskModel {
  final String? docId;
  final String? description;
  final String? userName;
  final String? startDate;
  final String? endDate;

  CreateTaskModel({
    this.docId,
    this.description,
    this.userName,
    this.startDate,
    this.endDate,
  });

  factory CreateTaskModel.fromJson(Map<String, dynamic> json) => CreateTaskModel(
    docId: json["docId"],
    description: json["description"],
    userName: json["userName"],
    startDate: json["startDate"],
    endDate: json["endDate"],
  );

  Map<String, dynamic> toJson(String docId) => {
    "docId": docId,
    "description": description,
    "userName": userName,
    "startDate": startDate,
    "endDate": endDate,
  };
}
