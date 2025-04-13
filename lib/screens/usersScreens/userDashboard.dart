import 'package:flutter/material.dart';

class userDashboard extends StatefulWidget {
  const userDashboard({super.key});

  @override
  State<userDashboard> createState() => _userDashboardState();
}

class _userDashboardState extends State<userDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("User Dashboard")
        ],
      ),
    );
  }
}
