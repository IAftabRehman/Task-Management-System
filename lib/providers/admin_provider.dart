import 'package:flutter/material.dart';
import 'package:task_management_system/services/adminServices.dart';
import 'package:task_management_system/services/userServices.dart';
import '../models/createTaskModel.dart';

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

}
