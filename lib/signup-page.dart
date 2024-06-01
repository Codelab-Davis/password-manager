import 'package:flutter/material.dart';
import 'package:password_manager/3rd_party_signin.dart';
import 'package:password_manager/main.dart';
import 'package:password_manager/totp-page.dart';
import 'package:timezone/data/latest.dart' as timezone;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:password_manager/global.dart';
import 'package:password_manager/route.dart';

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
  bool isHidden = true;

  bool isNameEntered = false;
  bool isEmailEntered = false;
  bool isPasswordEntered = false;
  bool isPasswordSame = false;
  bool is2faEntered = false;
  bool isReadyToSend = true;

  bool isFaceID = false;
  bool isSMS = false;
  bool is6digit = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getScaledSizeX(context, 16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: getScaledSizeY(context, 10)),
                  Text(
                    'Sign up to PassPal',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF323232),
                      fontSize: getScaledSizeX(context, 25),
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w800,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: getScaledSizeY(context, 5)),
                  Text(
                    'Enter your login details to create an account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF323232),
                      fontSize: getScaledSizeX(context, 16),
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: getScaledSizeY(context, 25)),
                  Text(
                    'Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF323232),
                      fontSize: getScaledSizeX(context, 16),
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: getScaledSizeY(context, 5)),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: isNameEntered == false
                          ? Border.all(color: Color.fromRGBO(48, 48, 48, 0.5))
                          : Border.all(color: Color(0xFFE50913)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'John Doe',
                        contentPadding: EdgeInsets.symmetric(horizontal: getScaledSizeX(context, 10)),
                      ),
                      controller: nameController,
                    ),
                  ),
                  SizedBox(height: getScaledSizeY(context, 5)),
                  Visibility(
                    visible: isNameEntered,
                    child: Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: Color(0xFFE50913),
                          size: getScaledSizeX(context, 20),
                        ),
                        SizedBox(width: getScaledSizeY(context, 5)),
                        Text(
                          'Invalid Name',
                          style: TextStyle(
                            color: Color(0xFFE50913),
                            fontSize: getScaledSizeX(context, 12),
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getScaledSizeY(context, 10)),
                  Text(
                    'Email',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF323232),
                      fontSize: getScaledSizeX(context, 16),
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: getScaledSizeY(context, 5)),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: isEmailEntered == false
                          ? Border.all(color: Color.fromRGBO(48, 48, 48, 0.5))
                          : Border.all(color: Color(0xFFE50913)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'johndoe@gmail.com',
                        contentPadding: EdgeInsets.symmetric(horizontal: getScaledSizeX(context, 10)),
                      ),
                      controller: emailController,
                    ),
                  ),
                  SizedBox(height: getScaledSizeY(context, 5)),
                  Visibility(
                    visible: isEmailEntered,
                    child: Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: Color(0xFFE50913),
                          size: getScaledSizeX(context, 20),
                        ),
                        SizedBox(width: getScaledSizeY(context, 5)),
                        Text(
                          'Invalid Email Address',
                          style: TextStyle(
                            color: Color(0xFFE50913),
                            fontSize: getScaledSizeX(context, 12),
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getScaledSizeY(context, 10)),
                  Text(
                    'Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF323232),
                      fontSize: getScaledSizeX(context, 16),
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: getScaledSizeY(context, 5)),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: isPasswordEntered == false
                          ? Border.all(color: Color.fromRGBO(48, 48, 48, 0.5))
                          : Border.all(color: Color(0xFFE50913)),
                    ),
                    child: TextField(
                      //obscureText: isHidden, // Use the isHidden variable here
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your password',
                        contentPadding: EdgeInsets.symmetric(horizontal: getScaledSizeX(context, 10)),
                      ),
                      controller: passwordController,
                    ),
                  ),
                  SizedBox(height: getScaledSizeY(context, 5)),
                  Visibility(
                    visible: isPasswordEntered,
                    child: Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: Color(0xFFE50913),
                          size: getScaledSizeX(context, 20),
                        ),
                        SizedBox(width: getScaledSizeY(context, 5)),
                        Text(
                          'Invalid Password',
                          style: TextStyle(
                            color: Color(0xFFE50913),
                            fontSize: getScaledSizeX(context, 12),
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getScaledSizeY(context, 10)),
                  Text(
                    'Confirm Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF323232),
                      fontSize: getScaledSizeX(context, 16),
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: getScaledSizeY(context, 5)),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: isPasswordSame == false
                          ? Border.all(color: Color.fromRGBO(48, 48, 48, 0.5))
                          : Border.all(color: Color(0xFFE50913)),
                    ),
                    child: TextField(
                      //obscureText: isHidden, // Use the isHidden variable here
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Re-enter your password',
                        contentPadding: EdgeInsets.symmetric(horizontal: getScaledSizeX(context, 10)),
                      ),
                      controller: confirmPasswordController,
                    ),
                  ),
                  SizedBox(height: getScaledSizeY(context, 5)),
                  Visibility(
                    visible: isPasswordSame,
                    child: Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: Color(0xFFE50913),
                          size: getScaledSizeX(context, 20),
                        ),
                        SizedBox(width: getScaledSizeY(context, 5)),
                        Text(
                          'Those passwords didn’t match. Try again.',
                          style: TextStyle(
                            color: Color(0xFFE50913),
                            fontSize: getScaledSizeX(context, 12),
                            fontFamily: 'Outfit',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getScaledSizeY(context, 37.5)),
                  Text(
                    'Select your two-factor authentication method',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF323232),
                      fontSize: getScaledSizeX(context, 15.5),
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            // Additional text and buttons outside of padding
            SizedBox(height: getScaledSizeY(context, 13)),
            Center(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align columns at the top
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              isFaceID = !isFaceID;
                              isSMS = false;
                              is6digit = false;
                            });
                            await updateTwoFAType(
                                'testing@gmail.com', 'FaceID');
                          },
                          child: Container(
                            width: getScaledSizeX(context, 120),
                            height: getScaledSizeY(context, 120),
                            decoration: BoxDecoration(
                              color: isFaceID
                                  ? Color(0xFFBCBCE0)
                                  : Color.fromARGB(255, 255, 253, 253),
                              shape: BoxShape.circle,
                              border: is2faEntered == false
                                  ? Border.all(
                                      color: Color.fromRGBO(48, 48, 48, 0.5))
                                  : Border.all(color: Color(0xFFE50913)),
                            ),
                            child: Icon(
                              Icons.face_rounded,
                              color: Colors.black,
                              size: getScaledSizeX(context, 60),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: getScaledSizeY(context, 10)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Face ID',
                              style: TextStyle(
                                fontSize: getScaledSizeX(context, 18),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: getScaledSizeX(context, 13)), // Add spacing between buttons
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              isSMS = !isSMS;
                              isFaceID = false;
                              is6digit = false;
                            });
                            await updateTwoFAType(
                                'testing@gmail.com', 'SMS Passcode');
                          },
                          child: Container(
                            width: getScaledSizeX(context, 120),
                            height: getScaledSizeY(context, 120),
                            decoration: BoxDecoration(
                              color: isSMS
                                  ? Color(0xFFBCBCE0)
                                  : Color.fromARGB(255, 255, 253, 253),
                              shape: BoxShape.circle,
                              border: is2faEntered == false
                                  ? Border.all(
                                      color: Color.fromRGBO(48, 48, 48, 0.5))
                                  : Border.all(color: Color(0xFFE50913)),
                            ),
                            child: Icon(
                              Icons.textsms_rounded,
                              color: Colors.black,
                              size: getScaledSizeX(context, 60),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: getScaledSizeY(context, 10)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'SMS Passcode',
                              style: TextStyle(
                                fontSize: getScaledSizeX(context, 18),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: getScaledSizeX(context, 13)), // Add spacing between buttons
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              is6digit = !is6digit;
                              isFaceID = false;
                              isSMS = false;
                            });
                            await updateTwoFAType(
                                'testing@gmail.com', '6-Digit Passcode');
                          },
                          child: Container(
                            //margin: const EdgeInsets.only(top: 20),
                            width: getScaledSizeX(context, 120),
                            height: getScaledSizeY(context, 120),
                            decoration: BoxDecoration(
                              color: is6digit
                                  ? Color(0xFFBCBCE0)
                                  : Color.fromARGB(255, 255, 253, 253),
                              shape: BoxShape.circle,
                              border: is2faEntered == false
                                  ? Border.all(
                                      color: Color.fromRGBO(48, 48, 48, 0.5))
                                  : Border.all(color: Color(0xFFE50913)),
                            ),
                            child: Icon(
                              Icons.dialpad_rounded,
                              color: Colors.black,
                              size: getScaledSizeX(context, 60),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: getScaledSizeY(context, 9)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '6-Digit\nPasscode',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: getScaledSizeX(context, 18),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: getScaledSizeY(context, 5)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getScaledSizeX(context, 12),
              ),
              child: Visibility(
                visible: is2faEntered,
                child: Row(
                  children: [
                    Icon(
                      Icons.error,
                      color: Color(0xFFE50913),
                      size: getScaledSizeX(context, 20),
                    ),
                    SizedBox(width: getScaledSizeY(context, 5)),
                    Text(
                      'Please select a two-factor authentication method',
                      style: TextStyle(
                        color: Color(0xFFE50913),
                        fontSize: getScaledSizeX(context, 12),
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: getScaledSizeY(context, 15)),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromRGBO(48, 48, 48, 0.5), // Outline color
              width: 1, // Outline width
            ),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: getScaledSizeY(context, 40)), // Adjust the margin here
          color: Colors.white,
          padding: EdgeInsets.all(getScaledSizeY(context, 16)),
          child: SizedBox(
            height: getScaledSizeX(context, 50),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(const Color(0xFFE4E4F9)),
                foregroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 255, 255, 255)), // Text color
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color(0xFF404447), // Add thin outline color
                      width: 0.5, // Add thin outline width
                    ),
                  ),
                ),
                padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(horizontal: getScaledSizeX(context, 16), vertical: getScaledSizeY(context, 6))),
              ),
              onPressed: () {
                isReadyToSend = true;

                String faType = twoFaType();
                String firstName = getFirstName(nameController.text);
                String lastName = getLastName(nameController.text);

                if (nameController.text.isEmpty) {
                  setState(() {
                    isNameEntered = true;
                    isReadyToSend = false;
                  });
                } else {
                  setState(() {
                    isNameEntered = false;
                  });
                }
                if (emailController.text.isEmpty ||
                    !emailController.text.contains('@')) {
                  setState(() {
                    isEmailEntered = true;
                    isReadyToSend = false;
                  });
                } else {
                  setState(() {
                    isEmailEntered = false;
                  });
                }
                if (passwordController.text.isEmpty) {
                  setState(() {
                    isPasswordEntered = true;
                    isReadyToSend = false;
                  });
                } else {
                  setState(() {
                    isPasswordEntered = false;
                  });
                }
                if (passwordController.text != confirmPasswordController.text) {
                  setState(() {
                    isPasswordSame = true;
                    isReadyToSend = false;
                  });
                } else {
                  setState(() {
                    isPasswordSame = false;
                  });
                }
                if (isFaceID == false && isSMS == false && is6digit == false) {
                  setState(() {
                    is2faEntered = true;
                    isReadyToSend = false;
                  });
                  return;
                } else {
                  setState(() {
                    is2faEntered = false;
                  });
                }
                if (isReadyToSend == true) {
                  postData(firstName, lastName, emailController.text,
                      passwordController.text, 'PassPal', faType);
                  //Now handle each 2fa type
                }
              },
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Color(0xFF323232),
                  fontSize: getScaledSizeX(context, 15),
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.bold,
                  height: 0.06,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String twoFaType() {
    if (isFaceID == true) {
      return 'FaceID';
    } else if (isSMS == true) {
      return 'SMS Passcode';
    } else if (is6digit == true) {
      return '6-Digit Passcode';
    } else {
      return 'N/A';
    }
  }
}
