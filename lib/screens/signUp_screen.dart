import 'package:flutter/material.dart';
import 'package:task_management_system/models/registrationModel.dart';
import 'package:task_management_system/services/authentication.dart';
import 'package:task_management_system/services/registrationServices.dart';

class signUp_screen extends StatefulWidget {
  const signUp_screen({super.key});

  @override
  State<signUp_screen> createState() => _signUp_screenState();
}

class _signUp_screenState extends State<signUp_screen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? _selectedGender;
  List<String> genders = ["Male", "Female", "Transgender"];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "SignUp",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  text: "Create an Account\n", // Main Heading
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Join us and manage your tasks efficiently!",
                      // Subheading
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  labelText: 'Enter Name',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue, // Text color
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: Colors.red,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Select Gender",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                value: _selectedGender,
                items:
                    genders.map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  labelText: 'Enter Email',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue, // Text color
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: Colors.red,
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue, // Text color
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: Colors.red,
              ),
              SizedBox(height: 10),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  labelText: 'Enter Phone',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue, // Text color
                  fontWeight: FontWeight.bold,
                ),
                cursorColor: Colors.red,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                        onPressed: () async {
                          if (nameController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Name would not be Empty"),
                              ),
                            );
                            return;
                          }
                          if (emailController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Email would not be Empty"),
                              ),
                            );
                            return;
                          }
                          if (passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Password would not be Empty"),
                              ),
                            );
                            return;
                          }
                          if (_selectedGender == null ||
                              _selectedGender!.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(_selectedGender.toString()),
                              ),
                            );
                            return;
                          }

                          try {
                            isLoading = true;
                            setState(() {});
                            await AuthenticationServices()
                                .registerUser(
                                  email: emailController.text,
                                  password: passwordController.text,
                                )
                                .then((val) async {
                                  await RegistrationServices()
                                      .createUser(
                                        RegistrationModel(
                                          name: nameController.text,
                                          gender: _selectedGender.toString(),
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phoneNumber: phoneController.text,
                                          docId: val!.uid.toString(),
                                          createdAt: DateTime.now().second,
                                        ),
                                      )
                                      .then((val) async {
                                        isLoading = false;
                                        setState(() {});
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("Message"),
                                              content: Text(
                                                "An email with verification link has been sent to your mail box.",
                                              ),
                                            );
                                          },
                                        );
                                      });
                                });
                          } catch (e) {
                            isLoading = false;
                            setState(() {});
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Text(
                          "SignUp",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text("Login", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
