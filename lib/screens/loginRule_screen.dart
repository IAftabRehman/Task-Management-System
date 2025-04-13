import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/userRegistration_provider.dart';

class loginRole_screen extends StatelessWidget {
  const loginRole_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<userRegistration_provider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Role", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login as a ....",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: provider.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: provider.passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Select Your Login Role", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => provider.loginAuthenticationUser(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      )
                    ),
                    child: Text(
                      "User Login",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => provider.loginAuthenticationAdmin(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                        )
                    ),
                    child: Text(
                      "Admin Login",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
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
