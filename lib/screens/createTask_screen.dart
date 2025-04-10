import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_system/providers/createTask_provider.dart';
import 'package:task_management_system/providers/userRegistration_provider.dart';

class createTask_screen extends StatefulWidget {
  const createTask_screen({super.key});

  @override
  State<createTask_screen> createState() => _createTask_screenState();
}

class _createTask_screenState extends State<createTask_screen> {
  String selectedItem = 'Option 1';

  DateTime? startDate;
  DateTime? endDate;
  String startDateText = "";
  String endDateText = "";

  final List<String> items = ["Option1", "Option2", "Option3"];

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
    }
  }

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
    }
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<createTask_provider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Create Task",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 5,
        shadowColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 1.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButton<String>(
                  value: selectedItem,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedItem = newValue!;
                    });
                  },
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  iconEnabledColor: Colors.blue,
                  dropdownColor: Colors.green.shade100,
                  isExpanded: true,
                  itemHeight: 60,
                  items:
                      items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Description",
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 55),
                ),
                onPressed: () => pickStartDate(context),
                child: Text(
                  "Start Date: $startDateText",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 55),
                ),
                onPressed: () => pickEndDate(context),
                child: Text(
                  "End Date: $endDateText",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
