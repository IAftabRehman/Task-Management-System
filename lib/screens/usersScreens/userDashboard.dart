import 'package:flutter/material.dart';

class userDashboard extends StatelessWidget {
  const userDashboard({super.key});

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
                    Text("2. Respect everyone's time, avoid unnecessary delays", style: TextStyle(fontSize: 17)),
                    SizedBox(height: 10),
                    Text("3. Ask for help if you're stuck on any task", style: TextStyle(fontSize: 17)),
                    SizedBox(height: 10),
                    Text("4. Do not copy tasks from others", style: TextStyle(fontSize: 17)),
                    SizedBox(height: 10),
                    Text("5. Only mark the task completed when it's fully done", style: TextStyle(fontSize: 17)),
                    SizedBox(height: 10),
                    Text("6. Log in daily to check for new tasks or updates", style: TextStyle(fontSize: 17)),
                  ],
                ),
              ),
            ],
        ),
      ),
    );
  }
}
