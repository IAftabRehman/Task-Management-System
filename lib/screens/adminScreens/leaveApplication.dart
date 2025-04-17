import 'package:flutter/material.dart';

class leaveApplication extends StatelessWidget {
  const leaveApplication({super.key});

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<admin_provider>(context);
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
          ),child: Text("Leave Application", style: TextStyle(fontSize: 30)),
        )
    );
  }
}
