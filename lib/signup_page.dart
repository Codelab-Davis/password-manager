import 'package:flutter/material.dart';
import 'package:password_manager/totp-page.dart';
import 'package:timezone/data/latest.dart' as timezone;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:password_manager/global.dart';
import 'package:password_manager/route.dart';

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 32.0),
              child: SizedBox(
                height: 30,
                child: Text(
                  'Sign up to Passpal',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF323232),
                    fontSize: 25,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: SizedBox(
                height: 50,
                child: Text(
                  'Enter your login details to get started',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF323232),
                    fontSize: 16,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'First Name',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF323232),
                  fontSize: 16,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal:
                      20.0), // Adds padding of 20 pixels to the left and right
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      10.0), // Rounded corners with a radius of 10 pixels
                  border: Border.all(), // Add border
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Remove default border
                    hintText: 'John',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0), // Adjust content padding
                  ),
                  controller: firstNameController,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Last Name',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF323232),
                  fontSize: 16,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0,
                  right:
                      20.0), // Adds padding of 20 pixels to the left and right
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      10.0), // Rounded corners with a radius of 10 pixels
                  border: Border.all(), // Add border
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Doe',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0), // Adjust content padding
                  ),
                  controller: lastNameController,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF323232),
                  fontSize: 16,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0,
                  right:
                      20.0), // Adds padding of 20 pixels to the left and right
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      10.0), // Rounded corners with a radius of 10 pixels
                  border: Border.all(), // Add border
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'johndoe@gmail.com',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0), // Adjust content padding
                  ),
                  controller: emailController,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Phone Number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF323232),
                  fontSize: 16,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0,
                  right:
                      20.0), // Adds padding of 20 pixels to the left and right
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      10.0), // Rounded corners with a radius of 10 pixels
                  border: Border.all(), // Add border
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'johndoe',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0), // Adjust content padding
                  ),
                  controller: phoneNumberController,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF323232),
                  fontSize: 16,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0,
                  right:
                      20.0), // Adds padding of 20 pixels to the left and right
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      10.0), // Rounded corners with a radius of 10 pixels
                  border: Border.all(), // Add border
                ),
                child: TextField(
                  obscureText: isHidden, // Use the isHidden variable here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your password',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0), // Adjust content padding
                  ),
                  controller: passwordController,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Confirm Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF323232),
                  fontSize: 16,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0,
                  right:
                      20.0), // Adds padding of 20 pixels to the left and right
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      10.0), // Rounded corners with a radius of 10 pixels
                  border: Border.all(), // Add border
                ),
                child: TextField(
                  obscureText: isHidden, // Use the isHidden variable here
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Re-enter your password',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0), // Adjust content padding
                  ),
                  controller: confirmPasswordController,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Visibility(
              visible:
                  isPasswordSame, // Set visibility based on the boolean variable
              child: const Padding(
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0,
                  right:
                      20.0), // Adds padding of 20 pixels to the left and right
              child: CheckboxListTile(
                value: isChecked,
                title: const Text('Show Password'),
                onChanged: (val) {
                  setState(() {
                    isChecked = val;
                    togglePassword();
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        setState(() {
                          isPasswordSame = true;
                        });
                        return;
                      }
                      setState(() {
                        isPasswordSame = false;
                      });
                      postData(
                          firstNameController.text,
                          lastNameController.text,
                          emailController.text,
                          phoneNumberController.text,
                          passwordController.text,
                          "Passpal",
                          );
                    },
                    child: const Text("Sign Up")),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GenerateTOTPPage(
                              secret: Global.result?.code ?? '')),
                    );
                  },
                  child: const Text('Generate TOTP'),
                ),
              ],
            ),
            const SizedBox(height: 65),
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