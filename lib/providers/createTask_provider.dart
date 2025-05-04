import 'package:flutter/material.dart';
import 'package:task_management_system/models/createTaskModel.dart';
import 'package:task_management_system/services/createTaskServices.dart';
import '../services/registrationServices.dart';

class createTask_provider with ChangeNotifier {
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  String selectedName = "";
  List<String> name = [];

  Future<void> fetchUserNames() async {
    try {
      List<String> userNames = await RegistrationServices().getAllUserNames();
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
    if(descriptionController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Description must not be empty")));
    }

    try {
      isLoading = true;
      notifyListeners();

      await CreateTaskServices().createTask(CreateTaskModel(
        taskId: DateTime.now().millisecondsSinceEpoch.toString(),
        userName: selectedName.toString(),
        description: descriptionController.text,
        startDate: startDateText.toString(),
        endDate: endDateText
      )).then((val) async {
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

  void disposeController() {
    descriptionController.dispose();
  }
}
