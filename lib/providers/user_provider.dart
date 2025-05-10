import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_management_system/models/createTaskModel.dart';
import 'package:task_management_system/models/updationTaskModel.dart';
import 'package:task_management_system/models/applyLeaveUpdationModel.dart';
import '../services/adminServices.dart';
import '../services/userServices.dart';

class user_provider with ChangeNotifier {
  // User Main Dashboard
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  // ------------------------------------------------------------------------------
  // Update Task
  // All Data Show
  List<Map<String, dynamic>> allTasks = [];

  Future<void> fetchAllTaskData() async {
    try {
      allTasks =
          (await AdminServices().getAllData()).cast<Map<String, dynamic>>();
      notifyListeners();
    } catch (e) {
      print("Error fetching task data: $e");
    }
  }

  // ------------------------------------------------------------------------------
  // Set Status
  List<String> action = ['Pending', 'In Progress', 'Completed'];
  final Map<String, String> _selectedActions = {};

  String getSelectedAction(String taskId) {
    return _selectedActions[taskId] ?? action[0];
  }

  void setSelectedAction(String taskId, String newValue) {
    _selectedActions[taskId] = newValue;
    notifyListeners();
  }

  // Update Action
  // getAllData
  Future<List<Map<String, dynamic>>> getAllData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance
            .collection("createTaskCollection")
            .get();

    List<Map<String, dynamic>> taskData =
        snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['docId'] = doc.id;
          return data;
        }).toList();

    return taskData;
  }

  Future<void> fatchAllTaskDataForUpdation(BuildContext context) async {
    try {
      allTasks =
          (await AdminServices().getAllData()).cast<Map<String, dynamic>>();

      for (var task in allTasks) {
        await UserServices().updationStatusData(
          UpdationTaskModel(
            status: _selectedActions.toString(),
            userName: task["userName"],
            description: task["description"],
            startDate: task["startDate"],
            endDate: task["endDate"],
            docId: task["docId"],
          ),
        );
      }
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> updateAction(BuildContext context) async {
    try {
      AdminServices().createTask(
        CreateTaskModel(status: _selectedActions.toString()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // ------------------------------------------------------------------------------
  // Apply Leave
  TextEditingController userNameController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  bool submitButton = false;

  Future<void> setApplyLeaveData(BuildContext context) async {
    if (userNameController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Name would not be empty")));
      return;
    }
    if (subjectController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Subject would not be empty")));
      return;
    }
    if (messageController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Message would not be empty")));
      return;
    }

    try {
      submitButton = true;
      notifyListeners();
      await UserServices()
          .setApplyLeaveDataIntoFirebase(
            applyLeaveUpdationModel(
              docId: DateTime.now().millisecondsSinceEpoch.toString(),
              subject: subjectController.text,
              message: messageController.text,
              userName: userNameController.text,
              status: "Pending",
            ),
          )
          .then((val) {
            submitButton = false;
            userNameController.clear();
            subjectController.clear();
            messageController.clear();
            notifyListeners();
          });
    } catch (e) {
      submitButton = false;
      notifyListeners();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // ----------------------------------------------------------------------------------
  // Application Status Data

  List<Map<String, dynamic>> applicationData = [];

  Future<void> getApplicationStatusData() async {
    try {
      applicationData =
          (await UserServices().getApplicationStatusData())
              ?.cast<Map<String, dynamic>>() ??
          [];
    } catch (e) {
      print("Error fetching task data: $e");
    }
  }
}
