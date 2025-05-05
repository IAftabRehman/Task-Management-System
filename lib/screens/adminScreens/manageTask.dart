import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/admin_provider.dart';

class manageTask extends StatefulWidget {
  const manageTask({super.key});

  @override
  State<manageTask> createState() => _manageTaskState();
}

class _manageTaskState extends State<manageTask> {
  @override
  void initState() {
    super.initState();
    Provider.of<admin_provider>(context, listen: false).fetchAllTaskData();
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
              provider.allTasks.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Task ID',
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
                          provider.allTasks.map((task) {
                            return DataRow(
                              cells: [
                                DataCell(Text(task['userName'] ?? '-')),
                                DataCell(Text(task['description'] ?? '-')),
                                DataCell(Text(task['startDate'] ?? '-')),
                                DataCell(Text(task['endDate'] ?? '-')),
                                DataCell(Text(task['status'] ?? '-')),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () => provider.showEditDialog(context, Map())
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (ctx) => AlertDialog(
                                                  title: Text("Confirm Delete"),
                                                  content: Text(
                                                    "Are you sure you want to delete this task?",
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed:
                                                          () => Navigator.pop(
                                                            ctx,
                                                          ),
                                                      child: Text("Cancel"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.pop(ctx);
                                                        await Provider.of<
                                                          admin_provider
                                                        >(
                                                          context,
                                                          listen: false,
                                                        ).deleteTaskById(
                                                          task['docId'],
                                                        ); // ✅ Use docId here
                                                      },
                                                      child: Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.delete,
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
