import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_system/providers/user_provider.dart';

class updateTask extends StatelessWidget {
  const updateTask({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<user_provider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Your Tasks")),
      body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("ID")),
                DataColumn(label: Text("Description")),
                DataColumn(label: Text("Start Date")),
                DataColumn(label: Text("End Date")),
                DataColumn(label: Text("Status")),
              ],
              rows: provider.tasks.map((task) {
                return DataRow(cells: [
                  DataCell(Text(task['docId'] ?? '')),
                  DataCell(Text(task['description'] ?? '')),
                  DataCell(Text(task['startDate'] ?? '')),
                  DataCell(Text(task['endDate'] ?? '')),
                  DataCell(Text(task['status'] ?? '')),
                ]);
              }).toList(),
            ),
      ),
    );
  }
}
