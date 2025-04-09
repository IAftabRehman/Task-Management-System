import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_system/providers/userRegistration_provider.dart';

class signUp_screen extends StatelessWidget {
  const signUp_screen({super.key});

  @override
  Widget build(BuildContext context) {
    print("Build");
    final provider = Provider.of<signUp_provider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("SignUp", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 8,
        shadowColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text.rich(
              TextSpan(
                text: "Create an Account\n",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: "Join us and manage your tasks efficiently!",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: provider.nameController,
              decoration: const InputDecoration(
                labelText: 'Enter Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Select Gender",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              value: provider.selectedGender,
              items: provider.genders.map((gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: provider.setGender,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: provider.emailController,
              decoration: const InputDecoration(
                labelText: 'Enter Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: provider.passwordController,
              decoration: const InputDecoration(
                labelText: 'Enter Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: provider.phoneController,
              decoration: const InputDecoration(
                labelText: 'Enter Phone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                provider.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () => provider.signUp(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text("SignUp", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () => provider.goToLoginScreen(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text("Login", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
