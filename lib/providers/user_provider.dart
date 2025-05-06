import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management_system/models/userModel.dart';
import '../services/userServices.dart';

class user_provider with ChangeNotifier {
  // User Main Dashboard
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  // Update Task
  final UserServices _taskService = UserServices();
  List<Map<String, dynamic>> _tasks = [];
  List<Map<String, dynamic>> get tasks => _tasks;

  Future<void> fetchTasks() async {
    _tasks = await _taskService.getTasksByUsername();
    notifyListeners();
  }

  // Apply Leave
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  bool submitButton = false;

  Future<String> getCurrentUserName() async {
    final user = FirebaseAuth.instance.currentUser;

    final doc = await FirebaseFirestore.instance.collection('registrationCollection').doc(user?.uid).get();
    return doc['name'] ? doc.data()!['name'] ?? "No Name Found" : "No Data Found";
  }

  Future<void> setApplyLeaveData(BuildContext context) async {
    if(subjectController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Subject would not be empty")));
      return;
    }
    if(messageController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Message would not be empty")));
      return;
    }

    try{
    submitButton = true;
    notifyListeners();
    String userName = getCurrentUserName().toString();

    await UserServices().setApplyLeaveDataIntoFirebase(
      UserModel(
        docId: DateTime.now().millisecondsSinceEpoch.toString(),
        userName: userName,
        subject: subjectController.text,
        message: messageController.text,
        createdBy: DateTime.now().millisecondsSinceEpoch,
      ),
    ).then((val)  {
      submitButton = false;
      subjectController.clear();
      messageController.clear();
      notifyListeners();
    });
    }catch(e){
      submitButton = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
