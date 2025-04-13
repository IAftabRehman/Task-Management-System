import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_system/providers/user_provider.dart';
import 'package:task_management_system/screens/usersScreens/applyLeave.dart';
import 'package:task_management_system/screens/usersScreens/leaveStatus.dart';
import 'package:task_management_system/screens/usersScreens/logOut.dart';
import 'package:task_management_system/screens/usersScreens/updateTask.dart';
import 'package:task_management_system/screens/usersScreens/userDashboard.dart';

class userMainDashboard_screen extends StatefulWidget {
  userMainDashboard_screen({super.key});

  @override
  State<userMainDashboard_screen> createState() => _userMainDashboard_screenState();
}

class _userMainDashboard_screenState extends State<userMainDashboard_screen> {
  int selected = 1;
  List<Widget> contentWidgets = [
    userDashboard(),
    updateTask(),
    applyLeave(),
    leaveStatus(),
    logOut()
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<user_provider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Dear Sir/Mam", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
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
                      onPressed: () {
                        selected = 0;
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      child: Text("Dashboard", style: TextStyle(fontSize: 15, color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selected = 1;
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      child: Text("Update Task", style: TextStyle(fontSize: 15, color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selected = 2;
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      child: Text("Apply Leave", style: TextStyle(fontSize: 15, color: Colors.white)),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selected = 3;
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      child: Text("Leave Status", style: TextStyle(fontSize: 15, color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selected = 4;
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      child: Text("LogOut", style: TextStyle(fontSize: 15, color: Colors.white)),
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
