import 'package:flutter/material.dart';

class updateTask extends StatefulWidget {
  const updateTask({super.key});

  @override
  State<updateTask> createState() => _updateTaskState();
}

class _updateTaskState extends State<updateTask> {
  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Task ID"),
                Text("Description"),
                Text("S-Date"),
                Text("E-Date"),
                Text("Status"),
                Text("Action"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
