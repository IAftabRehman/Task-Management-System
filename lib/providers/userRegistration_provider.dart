import 'package:flutter/material.dart';
import 'package:task_management_system/models/registrationModel.dart';
import 'package:task_management_system/screens/login_screen.dart';
import 'package:task_management_system/services/authentication.dart';
import 'package:task_management_system/services/registrationServices.dart';

class signUp_provider with ChangeNotifier {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String? selectedGender;
  List<String> genders = ["Male", "Female", "Transgender"];
  bool isLoading = false;

  void setGender(String? gender) {
    selectedGender = gender;
    notifyListeners();
  }

  void goToLoginScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const login_screen()),
    );
  }

  Future<void> loginAuthentication(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("All fields must be filled")));
    }

    try {
      isLoading = true;
      notifyListeners();

      await AuthenticationServices().loginUser(
        email: emailController.text,
        password: passwordController.text,
      );
      isLoading = false;
      notifyListeners();

      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Message"),
              content: Text("You are Logged In."),
            ),
      );
    } catch (e) {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
      return;
    }
  }

  Future<void> signUp(BuildContext context) async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        selectedGender == null ||
        selectedGender!.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("All fields must be filled!")));
      return;
    }
    if (passwordController.text.length <= 6) {
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

      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Message"),
              content: Text("An email with verification link has been sent."),
            ),
      );
    } catch (e) {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
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
