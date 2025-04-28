import 'dart:convert';

AdminModel adminModelFromJson(String str) => AdminModel.fromJson(json.decode(str));

String adminModelToJson(AdminModel data) => json.encode(data.toJson());

class AdminModel {
  final String? adminId;
  final String? createTask;
  final String? manageTask;
  final String? leaveApplication;
  final int? createAt;

  AdminModel({
    this.adminId,
    this.createTask,
    this.manageTask,
    this.leaveApplication,
    this.createAt,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
    adminId: json["adminId"],
    createTask: json["createTask"],
    manageTask: json["manageTask"],
    leaveApplication: json["leaveApplication"],
    createAt: json["createAt"],
  );

  Map<String, dynamic> toJson() => {
    "adminId": adminId,
    "createTask": createTask,
    "manageTask": manageTask,
    "leaveApplication": leaveApplication,
    "createAt": createAt,
  };
}
