import 'dart:async';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For clipboard operations
import 'package:otp/otp.dart';
import 'package:password_manager/totp_generator.dart';
import 'package:timezone/data/latest.dart' as timezone;
import 'package:timezone/timezone.dart' as timezone;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'welcome_screen.dart';

void main() {
  runApp(const MyApp());
  timezone.initializeTimeZones();
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
      home: WelcomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

postData(String email, String password) async {
  try {
    var url = Uri.http('localhost:5000', '/test/add');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    //print('Response status: ${response.statusCode}'); //Helpful for debugging
    //print('Response body: ${response.body}'); //Helpful for debugging
  } catch (e) {
    print(e);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  bool isHidden = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0,
                  right:
                      20.0), // Adds padding of 20 pixels to the left and right
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Email:'),
                controller: emailController,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0,
                  right:
                      20.0), // Adds padding of 20 pixels to the left and right
              child: TextField(
                obscureText: isHidden, // Use the isHidden variable here
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Password:',
                  suffixIcon: IconButton(
                    onPressed: togglePassword,
                    icon: Icon(
                      isHidden ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
                controller: passwordController,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  postData(emailController.text, passwordController.text);
                },
                child: const Text("Submit")),
            const SizedBox(height: 150),
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
}

