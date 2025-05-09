import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/admin_provider.dart';

class leaveApplication extends StatefulWidget {
  const leaveApplication({super.key});

  @override
  State<leaveApplication> createState() => _leaveApplicationState();
}

class _leaveApplicationState extends State<leaveApplication> {
  @override
  void initState() {
    super.initState();
    Provider.of<admin_provider>(context, listen: false).fetchLeaveApplication();
  }

  @override
  Widget build(BuildContext context) {
   final provider = Provider.of<admin_provider>(context);
   final mediaHeight = MediaQuery.of(context).size.height;
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
          provider.leaveApplication.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(
                  label: Text(
                    'User Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Subject',
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
                    'Action',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
              rows:
              provider.leaveApplication.map((task) {
                return DataRow(
                  cells: [
                    DataCell(Text(task['userName'] ?? '-')),
                    DataCell(Text(task['subject'] ?? '-')),
                    DataCell(Text(task['description'] ?? '-')),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.done_all_sharp,
                                color: Colors.blue,
                              ),
                              onPressed: () => provider.getUpdateLeaveStatus(context, false)
                          ),
                          IconButton(
                            onPressed: () => provider.getUpdateLeaveStatus(context, true),
                            icon: Icon(
                              Icons.add_box_rounded,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
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
