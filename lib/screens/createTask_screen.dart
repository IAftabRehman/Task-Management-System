import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_system/providers/createTask_provider.dart';

class createTask_screen extends StatelessWidget {
  const createTask_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<createTask_provider>(context, listen: true);
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
                  value: provider.selectedItem,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  iconEnabledColor: Colors.blue,
                  dropdownColor: Colors.green.shade100,
                  isExpanded: true,
                  itemHeight: 60,
                  items: provider.items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      provider.updateSelectedItem(newValue);
                    }
                  },
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
                onPressed: () => provider.pickStartDate(context),
                child: Text(
                  "Start Date: ${provider.startDateText}",
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
                onPressed: () => provider.pickEndDate(context),
                child: Text(
                  "End Date: ${provider.endDateText}",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 40),

              ElevatedButton(onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Colors.blue,
                    minimumSize: Size(100, 55),
                  ),child: Text("Create Task", style: TextStyle(fontSize: 20, color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }
}