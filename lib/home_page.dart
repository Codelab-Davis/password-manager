import 'dart:async';
import 'dart:io';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/totp_generator.dart';
import 'package:timezone/data/latest.dart' as timezone;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'welcome_screen.dart';

bool isPasswordSame = false;
void main() {
  timezone.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter OTP Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Sign Up'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

postData(String firstName, String lastName, String email, String phoneNumber, String password) async {
  isPasswordSame = false;
  try {
    print('In PostData');
    var url = Uri.http('localhost:5000', '/test/add'); 
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
      }),
    );
    print('Response status: ${response.statusCode}'); //Helpful for debugging
    print('Response body: ${response.body}'); //Helpful for debugging
  } catch (e) {
    print(e);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  bool? isChecked = false;
  bool isHidden = true;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding (
              padding: const EdgeInsets.only(left: 20.0, right: 20.0), // Adds padding of 20 pixels to the left and right
              child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(), 
                    hintText: 'First Name'
                    ),
                  controller: firstNameController,
              ),
            ),
            const SizedBox(height: 15),
            
            Padding (
              padding: const EdgeInsets.only(left: 20.0, right: 20.0), // Adds padding of 20 pixels to the left and right
              child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(), 
                    hintText: 'Last Name'
                    ),
                  controller: lastNameController,
              ),
            ),
            const SizedBox(height: 15),
            
            Padding (
              padding: const EdgeInsets.only(left: 20.0, right: 20.0), // Adds padding of 20 pixels to the left and right
              child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(), 
                    hintText: 'Email'
                    ),
                  controller: emailController,
              ),
            ),
            const SizedBox(height: 15),
            
            Padding (
              padding: const EdgeInsets.only(left: 20.0, right: 20.0), // Adds padding of 20 pixels to the left and right
              child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(), 
                    hintText: 'Phone Number'
                    ),
                  controller: phoneNumberController,
              ),
            ),
            const SizedBox(height: 15),
            
            Padding (
              padding: const EdgeInsets.only(left: 20.0, right: 20.0), // Adds padding of 20 pixels to the left and right
              child:
              TextField(
                obscureText: isHidden, // Use the isHidden variable here
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
                controller: passwordController,
              ),
            ),
            const SizedBox(height: 15),
            
            Padding (
              padding: const EdgeInsets.only(left: 20.0, right: 20.0), // Adds padding of 20 pixels to the left and right
              child:
              TextField(
                obscureText: isHidden, // Use the isHidden variable here
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Confirm Password',
                ),
                controller: confirmPasswordController,
              ),
            ),
            const SizedBox(height: 15),
            
            Visibility(
              visible: isPasswordSame, // Set visibility based on the boolean variable
              child: const Padding (
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    Icon(Icons.error_outline_rounded, color: Colors.red),
                    SizedBox(width: 5),
                    Text(
                      'Those passwords didn’t match. Try again.',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),

            Padding (
              padding: const EdgeInsets.only(left: 20.0, right: 20.0), // Adds padding of 20 pixels to the left and right
              child:
              CheckboxListTile(
                value: isChecked,
                title: Text('Show Password'),
                onChanged: (val){
                  setState(() {
                    isChecked = val;
                    togglePassword();
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,     
              ),
            ),            
            const SizedBox(height: 30),
              
            ElevatedButton(
              onPressed: () {
                if (passwordController.text != confirmPasswordController.text) {
                  setState(() {
                    isPasswordSame = true;
                  });
                  return;
                }
                setState(() {
                  isPasswordSame = false;
                });
                postData(firstNameController.text, lastNameController.text, emailController.text, phoneNumberController.text, passwordController.text);   
              },
            child: const Text("Sign Up")
      ),
            const SizedBox(height: 5),
            
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenerateTOTPPage()),
                );
              },
              child: const Text('Generate TOTP'),
            ),
          ],
        ),
      ),
    );
  }
  
  void togglePassword() {
    setState(() {
      isHidden = !isHidden;
    });
  }
  // bool isIdentical() {

  // }
}
