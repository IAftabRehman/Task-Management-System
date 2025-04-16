import 'package:flutter/material.dart';

class leaveStatus extends StatefulWidget {
  const leaveStatus({super.key});

  @override
  State<leaveStatus> createState() => _leaveStatusState();
}

class _leaveStatusState extends State<leaveStatus> {
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
                Text("S.No"),
                Text("Subject"),
                Text("Message"),
                Text("Status"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
