import 'package:flutter/material.dart';

class updateTask extends StatefulWidget {
  const updateTask({super.key});

  @override
  State<updateTask> createState() => _updateTaskState();
}

class _updateTaskState extends State<updateTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Update Task")
        ],
      ),
    );
  }
}
