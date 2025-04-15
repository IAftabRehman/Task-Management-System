import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_system/providers/user_provider.dart';

class userDashboard extends StatefulWidget {
  const userDashboard({super.key});

  @override
  State<userDashboard> createState() => _userDashboardState();
}

class _userDashboardState extends State<userDashboard> {
  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 5),
                child: Text("Instruction for Student", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("1. Everyone must completed the tasks assigned to them", style: TextStyle(fontSize: 17)),
                    SizedBox(height: 10),
                    Text("2. Kindly maintain decorum of the office", style: TextStyle(fontSize: 17)),
                    SizedBox(height: 10),
                    Text("3. Keep office and your area neat and clean", style: TextStyle(fontSize: 17)),
                  ],
                ),
              ),
            ],
        ),
      ),
    );
  }
}
