import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_system/providers/user_provider.dart';

class applicationStatusData extends StatefulWidget {
  const applicationStatusData({super.key});

  @override
  State<applicationStatusData> createState() => _applicationStatusDataState();
}

class _applicationStatusDataState extends State<applicationStatusData> {
  @override
  void initState() {
    super.initState();
    Provider.of<user_provider>(
      context,
      listen: false,
    ).getApplicationStatusData();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<user_provider>(context);
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
        child:
            provider.applicationData.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20,
                    columns: const [
                      DataColumn(
                        label: Text(
                          'User Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Application',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Status',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows:
                        provider.applicationData.map((item) {
                          return DataRow(
                            cells: [
                              DataCell(Text(item['userName'])),
                              DataCell(Text("It is reviewed by Admin Side")),
                              DataCell(Text(item['status'])),
                            ],
                          );
                        }).toList(),
                  ),
                ),
      ),
    );
  }
}
