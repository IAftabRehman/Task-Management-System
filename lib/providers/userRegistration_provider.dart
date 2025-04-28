import 'package:flutter/material.dart';
import 'package:task_management_system/models/registrationModel.dart';
import 'package:task_management_system/screens/createTask_screen.dart';
import 'package:task_management_system/screens/loginRule_screen.dart';
import 'package:task_management_system/screens/signUp_screen.dart';
import 'package:task_management_system/services/authentication.dart';
import 'package:task_management_system/services/registrationServices.dart';

class userRegistration_provider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String? selectedGender, selectedRole;
  List<String> genders = ["Male", "Female", "Transgender"];
  List<String> role = ["Teacher/Admin", "Student/User"];
  bool isLoading = false;

  void setGender(String? gender) {
    selectedGender = gender;
    notifyListeners();
  }

  void setRole(String? role) {
    selectedRole = role;
    notifyListeners();
  }

  // SignUp to Login Screen
  void loginScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => loginRole_screen()),
    );
  }

  // SignUp (User Data)
  Future<void> signUp(BuildContext context) async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        selectedGender == null ||
        selectedGender!.isEmpty ||
        selectedRole == null ||
        selectedRole!.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("All fields must be filled!")));
      return;
    }
    if (passwordController.text.length <= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password would be 6 or more characters")),
      );
      return;
    }
    try {
      isLoading = true;
      notifyListeners();
      final val = await AuthenticationServices().registerUser(
        email: emailController.text,
        password: passwordController.text,
      );
      await RegistrationServices().createUser(
        RegistrationModel(
          name: nameController.text,
          userRole: selectedRole!,
          gender: selectedGender!,
          email: emailController.text,
          password: passwordController.text,
          phoneNumber: phoneController.text,
          docId: val!.uid,
          createdAt: DateTime.now().second,
        ),
      );

      isLoading = false;
      notifyListeners();

      await Future.delayed(Duration(milliseconds: 500));

      if(selectedRole == "Teacher/Admin"){
        Navigator.push(context, MaterialPageRoute(builder: (context) => createTask_screen()));
      }else if(selectedRole == "Student/User"){
        Navigator.push(context, MaterialPageRoute(builder: (context) => loginRole_screen()));
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // Login Admin
  void loginAuthenticationAdmin(BuildContext context) async {
    String enteredEmail = emailController.text;
    String enteredPassword = passwordController.text;

    if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("All fields must be filled")));
      return;
    }

    try {
      await AuthenticationServices().loginUser(
        email: enteredEmail,
        password: enteredPassword,
      );
      String? role = await RegistrationServices().getUserRoleByEmail(
        enteredEmail,
      );

      if (role == "Teacher/Admin") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => createTask_screen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid Login or Invalid Role")),
        );
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  // Login User
  void loginAuthenticationUser(BuildContext context) async {
    String enteredEmail = emailController.text;
    String enteredPassword = passwordController.text;

    if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("All fields must be filled")));
      return;
    }

    try {
      await AuthenticationServices().loginUser(
        email: enteredEmail,
        password: enteredPassword,
      );
      String? role = await RegistrationServices().getUserRoleByEmail(
        enteredEmail,
      );

      if (role == "Student/User") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => signUp_screen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid Login or Invalid Role")),
        );
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
