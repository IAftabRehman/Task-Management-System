import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_system/providers/admin_provider.dart';


class createTask extends StatefulWidget {
  const createTask({super.key});

  @override
  State<createTask> createState() => _createTaskState();
}

class _createTaskState extends State<createTask> {

  @override
  void initState() {
    super.initState();
    Provider.of<admin_provider>(context, listen: false).fetchUserNames();
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<admin_provider>(context, listen: true);
    final mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: mediaHeight * 0.7,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              boxShadow: [
                BoxShadow(
                  color: Colors.greenAccent,
                  spreadRadius: 3,
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
          child: Padding(
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
                    child: Consumer<admin_provider>(
                      builder: (context, provider, child) {
                        return DropdownButton<String>(
                          value: provider.selectedName.isNotEmpty ? provider.selectedName : null,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          iconEnabledColor: Colors.blue,
                          dropdownColor: Colors.green.shade100,
                          isExpanded: true,
                          itemHeight: 60,
                          hint: const Text("Select a user"),
                          items: provider.name.map((String value) {
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
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: provider.descriptionController,
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

                  provider.isLoading ? Center(child: CircularProgressIndicator()) :
                  ElevatedButton(onPressed: (){
                    provider.pushTaskDetails(context);
                  },
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
        ),
      ),
    );
  }
}