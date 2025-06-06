import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_system/providers/user_provider.dart';
import 'package:task_management_system/screens/adminScreens/adminDashboard.dart';
import 'package:task_management_system/screens/adminScreens/createTask.dart';
import 'package:task_management_system/screens/adminScreens/leaveApplication.dart';
import 'package:task_management_system/screens/adminScreens/manageTask.dart';
import 'package:task_management_system/screens/adminScreens/logOut.dart';

class adminMainDashboard_screen extends StatefulWidget {
  adminMainDashboard_screen({super.key});

  @override
  State<adminMainDashboard_screen> createState() =>
      _adminMainDashboard_screenState();
}

class _adminMainDashboard_screenState extends State<adminMainDashboard_screen> {
  int selected = 0;

  List<Widget> contentWidgets = [
    adminDashboard(),
    createTask(),
    manageTask(),
    leaveApplication(),
    logOut(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<user_provider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dear Sir/Mam",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 10,
        shadowColor: Colors.blue,
      ),

      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.red,
              child: contentWidgets[provider.selectedIndex],
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => provider.changeIndex(0),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        "Dashboard",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => provider.changeIndex(1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        "Create Task",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => provider.changeIndex(2),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        "Manage Task",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => provider.changeIndex(3),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        "Leave Application",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => provider.changeIndex(4),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        "LogOut",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
