import 'dart:convert';

AdminModel adminModelFromJson(String str) => AdminModel.fromJson(json.decode(str));

String adminModelToJson(AdminModel data) => json.encode(data.toJson());

class AdminModel {
  final String? adminId;
  final String? createTask;
  final String? leaveApplication;
  final bool? logOut;
  final String? manageTask;

  AdminModel({
    this.adminId,
    this.createTask,
    this.leaveApplication,
    this.logOut,
    this.manageTask,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
    adminId: json["adminId"],
    createTask: json["createTask"],
    leaveApplication: json["leaveApplication"],
    logOut: json["logOut"],
    manageTask: json["manageTask"],
  );

  Map<String, dynamic> toJson() => {
    "adminId": adminId,
    "createTask": createTask,
    "leaveApplication": leaveApplication,
    "logOut": logOut,
    "manageTask": manageTask,
  };
}
