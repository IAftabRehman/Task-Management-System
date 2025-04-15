import 'dart:convert';

CreateTaskModel createTaskModelFromJson(String str) => CreateTaskModel.fromJson(json.decode(str));


class CreateTaskModel {
  final String? taskId;
  final String? description;
  final String? userName;
  final String? startDate;
  final String? endDate;
  final String? status;

  CreateTaskModel({
    this.taskId,
    this.description,
    this.userName,
    this.startDate,
    this.endDate,
    this.status,
  });

  factory CreateTaskModel.fromJson(Map<String, dynamic> json) => CreateTaskModel(
    taskId: json["docId"],
    description: json["description"],
    userName: json["userName"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    status: json["status"],
  );

  Map<String, dynamic> toJson(String docId) => {
    "docId": docId,
    "description": description,
    "userName": userName,
    "startDate": startDate,
    "endDate": endDate,
    "status": status,
  };
}
