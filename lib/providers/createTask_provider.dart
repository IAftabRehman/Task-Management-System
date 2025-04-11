import 'package:flutter/material.dart';

class createTask_provider with ChangeNotifier {
  TextEditingController descriptionController = TextEditingController();

  String selectedItem = 'Option1';
  final List<String> items = ["Option1", "Option2", "Option3"];

  DateTime? startDate;
  DateTime? endDate;
  String startDateText = "";
  String endDateText = "";

  // Update dropdown
  void updateSelectedItem(String value) {
    selectedItem = value;
    notifyListeners();
  }

  Future<void> pushTaskDetails(BuildContext context) async {
    try {

    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
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

  // Dispose the controller
  void disposeController() {
    descriptionController.dispose();
  }
}
