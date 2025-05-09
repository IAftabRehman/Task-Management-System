import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_management_system/screens/adminScreens/leaveApplication.dart';
import 'package:task_management_system/services/adminServices.dart';
import 'package:task_management_system/services/authentication.dart';
import 'package:task_management_system/services/userServices.dart';
import '../models/applyLeaveUpdationModel.dart';
import '../models/createTaskModel.dart';
import '../models/leaveStatusModel.dart';

class admin_provider with ChangeNotifier {
  // User Main Dashboard
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  void changeIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }
  //-----------------------------------------------------------------------------------
  // Create Task
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  String selectedName = "";
  List<String> name = [];
  Future<void> fetchUserNames() async {
    try {
      List<String> userNames = await AdminServices().getAllUserNames();
      name.clear();
      name.addAll(userNames);
      selectedName = name.isNotEmpty ? name[0] : 'No users found';
      notifyListeners();
    } catch (e) {
      print("Error fetching usernames: $e");
    }
  }

  DateTime? startDate;
  DateTime? endDate;
  String startDateText = "";
  String endDateText = "";

  void updateSelectedItem(String value) {
    selectedName = value;
    notifyListeners();
  }

  // Pick start date
  Future<void> pickStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      startDate = picked;
      startDateText = "${picked.day}/${picked.month}/${picked.year}";
      notifyListeners();
    }
  }

  // Pick end date
  Future<void> pickEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      endDate = picked;
      endDateText = "${picked.day}/${picked.month}/${picked.year}";
      notifyListeners();
    }
  }

  Future<void> pushTaskDetails(BuildContext context) async {
    if (descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Description must not be empty")));
    }

    try {
      isLoading = true;
      notifyListeners();

      await AdminServices()
          .createTask(
            CreateTaskModel(
              taskId: DateTime.now().millisecondsSinceEpoch.toString(),
              userName: selectedName.toString(),
              description: descriptionController.text,
              startDate: startDateText.toString(),
              endDate: endDateText.toString(),
              status: "Progress"
            ),
          )
          .then((val) async {
            isLoading = false;
            descriptionController.clear();
            notifyListeners();
          });
    } catch (e) {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }


//-----------------------------------------------------------------------------------

  String selectedTask = "";
  List<String> Taskname = [];
  Future<void> fetchTaskInformation() async {
    try {
      List<String> userNames = await UserServices().getTaskFromAdminSide();
      Taskname.clear();
      Taskname.addAll(userNames);
      selectedTask = Taskname.isNotEmpty ? Taskname[0] : 'No users found';
      notifyListeners();
    } catch (e) {
      print("Error fetching usernames: $e");
    }
  }


  //-------------------------------------------------------------------------------
  // Manage File
  // 1. All Data Show
  List<Map<String, dynamic>> allTasks = [];
  Future<void> fetchAllTaskData() async {
    try {
      allTasks = (await AdminServices().getAllData()).cast<Map<String, dynamic>>();
      notifyListeners();
    } catch (e) {
      print("Error fetching task data: $e");
    }
  }

  // 2. Delete Task
  Future<void> deleteTaskById(String docId) async {
    await FirebaseFirestore.instance
        .collection("createTaskCollection")
        .doc(docId)
        .delete();
    await fetchAllTaskData();
  }

  // 3. Edit Task
  Future<void> editTask(String docId, Map<String, dynamic> updatedData) async {
    await AdminServices().updateTaskById(docId, updatedData);
    await fetchAllTaskData();
  }

  void showEditDialog(BuildContext context, Map<String, dynamic> task) {
    final descriptionController = TextEditingController(text: task['description']);
    final startDateController = TextEditingController(text: task['startDate']);
    final endDateController = TextEditingController(text: task['endDate']);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Edit Task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: "Description")),
            TextField(controller: startDateController, decoration: InputDecoration(labelText: "Start Date")),
            TextField(controller: endDateController, decoration: InputDecoration(labelText: "End Date")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              final updatedData = {
                "description": descriptionController.text,
                "startDate": startDateController.text,
                "endDate": endDateController.text,
              };

              await editTask(task['docId'], updatedData);

              Navigator.pop(ctx);
            },
            child: Text("Save", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }


  // ------------------------------------------------------------------------------------------
  // LogOut
  String? currentId = FirebaseAuth.instance.currentUser?.uid;
  String? _currentEmail;

  String? get currentEmail => _currentEmail;

  Future<void> getEmail() async {
  _currentEmail = await AdminServices().currentEmail(currentId!);
  print("Current Email: $_currentEmail");
  notifyListeners();
  }

  // Click in Logout Button
  final AuthenticationServices _authService = AuthenticationServices();
  Future<void> logoutUser() async {
    await _authService.logoutUser();
    notifyListeners();
  }

  //-----------------------------------------------------------------------------------------------
  // Leave Application
  List<Map<String, dynamic>> leaveApplication = [];
  Future<void> fetchLeaveApplication() async {
    try {
      leaveApplication = (await AdminServices().getLeaveApplicationData()).cast<Map<String, dynamic>>();
      notifyListeners();
    } catch (e) {
      print("Error fetching task data: $e");
    }
  }


  Future<void> getUpdateLeaveStatus(BuildContext context, bool value) async{
    bool accept = false;
    bool reject = true;
    String hello = "";
    if(accept == value){
      hello = "Accept";
    }if(reject == value){
      hello = "reject";
    }
    TextEditingController nameController = TextEditingController();

    notifyListeners();
    try{

      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text("Enter Student Name"),
            content: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Student Name",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text;
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Name entered: $name")),
                  );
                },
                child: const Text("Submit"),
              ),
            ],
          );
        },
      ).then((onValue)async{
        await  AdminServices().leaveApplicationStatus(
            LeaveStatusModel(
                docId: DateTime.now().millisecondsSinceEpoch.toString(),
                userName: nameController.text,
                status: hello.toString()
            )
        );
      });


    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

}
