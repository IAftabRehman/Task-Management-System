import 'package:flutter/material.dart';

class splash_Screen extends StatelessWidget {
  const splash_Screen({super.key});
  @override
  Widget build(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/images/splashScreen.gif', width: width * 1, height: height * 1, fit: BoxFit.cover)
        ],
      ),
    );
  }
}

