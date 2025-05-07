import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_system/providers/admin_provider.dart';
import 'package:task_management_system/providers/user_provider.dart';

class updateTask extends StatefulWidget {
  const updateTask({super.key});

  @override
  State<updateTask> createState() => _updateTaskState();
}

class _updateTaskState extends State<updateTask> {
  @override
  void initState() {
    super.initState();
    Provider.of<admin_provider>(context, listen: false).fetchAllTaskData();
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    final provider = Provider.of<user_provider>(context);
    final provider1 = Provider.of<admin_provider>(context);
    return Scaffold(
      body: Container(
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
          padding: const EdgeInsets.all(16.0),
          child:
          provider1.allTasks.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Text(
                    'Student Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Start Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'End Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Status',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Action',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
              rows:
              provider1.allTasks.map((task) {
                return DataRow(
                  cells: [
                    DataCell(Text(task['userName'] ?? '-')),
                    DataCell(Text(task['description'] ?? '-')),
                    DataCell(Text(task['startDate'] ?? '-')),
                    DataCell(Text(task['endDate'] ?? '-')),
                    DataCell(
                      DropdownButtonFormField<String>(
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                        iconSize: 30,
                        dropdownColor: Colors.blue.shade100,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText: provider.getSelectedAction(task['docId']),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        value: provider.getSelectedAction(task['docId']),
                        items: provider.action.map((role) {
                          return DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            provider.setSelectedAction(task['docId'], newValue);
                          }
                        },
                      ),
                    ),
                    DataCell(
                      ElevatedButton(
                        onPressed: () => provider.fatchAllTaskDataForUpdation(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.all(10),
                        ),
                        child: Text("Update", style: TextStyle(color: Colors.white, fontSize: 14)),
                      )
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
