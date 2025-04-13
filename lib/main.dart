import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_system/providers/createTask_provider.dart';
import 'package:task_management_system/providers/userRegistration_provider.dart';
import 'package:task_management_system/providers/user_provider.dart';
import 'package:task_management_system/screens/userMainDashboard_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => userRegistration_provider()),
        ChangeNotifierProvider(create: (_) => createTask_provider()),
        ChangeNotifierProvider(create: (_) => user_provider())
      ],
      child: Builder(builder: (BuildContext context){
        return MaterialApp(
          theme: ThemeData(
              primaryColor: Colors.blue,
              brightness: Brightness.light
          ),
          darkTheme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: Brightness.dark
          ),

          debugShowCheckedModeBanner: false,
          home: userMainDashboard_screen(),
        );
      }),
    );
  }
}

