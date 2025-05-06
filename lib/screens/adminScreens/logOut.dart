import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/admin_provider.dart';

class logOut extends StatefulWidget {
  const logOut({super.key});

  @override
  State<logOut> createState() => _logOutState();
}

class _logOutState extends State<logOut> {
  @override
  void initState() {
    super.initState();
    // Call the getEmail function
    Provider.of<admin_provider>(context, listen: false).getEmail();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<admin_provider>(context, listen: true);
    final mediaHeight = MediaQuery.of(context).size.height;

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("LogOut", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text(
                provider.currentEmail ?? "Loading email...",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () => provider.logoutUser(), child: Text("LogOut", style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold)), style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,

              ))
            ],
          ),
        ),
      ),
    );
  }
}
