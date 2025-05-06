import 'package:flutter/material.dart';
import '../../services/authentication.dart';

class logOut extends StatefulWidget {
  const logOut({super.key});

  @override
  State<logOut> createState() => _logOutState();
}

class _logOutState extends State<logOut> {

  final auth = AuthenticationServices();
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
            Text("LogOut", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () async {
                await auth.logoutUser();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text("LogOut"),
            ),
          ],
        ),
      ),
    );
  }
}