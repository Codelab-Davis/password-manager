import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:password_manager/profile-page.dart';
import 'package:gen_art_bg/gen_art_bg.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool showCurrentPassword = true;
  bool showNewPassword = true;
  bool showConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Change Password',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, 
          // Set the icon color to black
        ), systemOverlayStyle: SystemUiOverlayStyle.dark,
        
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Transform.scale(
            scale: 1.1, // Adjust the scale factor to slightly increase the size
            child: Container(
              margin: const EdgeInsets.only(top: 100),
              height:
                  100, // Define a specific height for the AnimatedLines widget
              width: 500,
              child: Row(
                children: [
                  Expanded(
                    child: AnimatedLines(
                      numberOfLines: 30, // Number of lines
                      lineLength: MediaQuery.of(context)
                          .size
                          .width, // Length of each line to cover the full width
                      lineColor: Color.fromARGB(
                          255, 224, 187, 255), // Color of each line
                      strokeWidth: 1, // Stroke width of each line
                      animationDuration: 50, // Duration of the animation
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Current Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF323232),
                  fontSize: 16,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: ShapeDecoration(
                color: Color(0xFFFFFDFC),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0x7F303030)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  obscureText: showCurrentPassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Password',
                    suffixIcon: IconButton(
                      icon: Icon(showCurrentPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          showCurrentPassword = !showCurrentPassword;
                        });
                      },
                    ),
                  ),
                  controller: currentPasswordController,
                ),
              ),
            ),
          ),
          const SizedBox(height: 35),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'New Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF323232),
                  fontSize: 16,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: ShapeDecoration(
                color: Color(0xFFFFFDFC),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0x7F303030)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  obscureText: showNewPassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'New Password',
                    suffixIcon: IconButton(
                      icon: Icon(showNewPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          showNewPassword = !showNewPassword;
                        });
                      },
                    ),
                  ),
                  controller: newPasswordController,
                ),
              ),
            ),
          ),
          const SizedBox(height: 35),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Confirm Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF323232),
                  fontSize: 16,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: ShapeDecoration(
                color: Color(0xFFFFFDFC),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0x7F303030)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  obscureText: showConfirmPassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Re-enter New Password',
                    suffixIcon: IconButton(
                      icon: Icon(showConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          showConfirmPassword = !showConfirmPassword;
                        });
                      },
                    ),
                  ),
                  controller: confirmPasswordController,
                ),
              ),
            ),
          ),
          const SizedBox(height: 65),
          Container(
            width: 140,
            height: 50,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              shadows: const [
                BoxShadow(
                  color: Color.fromARGB(18, 0, 0, 0),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                )
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserProfilePage(),
                        ),
                      );
                    });
                    return const AlertDialog(
                      title: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Icon(
                          Icons.check_circle,
                          color: Color(0xFF374375),
                          size: 80,
                        ),
                      ),
                      content: SizedBox(
                        width: 350,
                        height: 80,
                        child: Text(
                          'You’ve successfully changed\n your password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF323232),
                            fontSize: 18,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                surfaceTintColor: Color(0xFFE4E4F9),
                foregroundColor: Color(0xFFE4E4F9),
                backgroundColor: Color(0xFFE4E4F9),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadowColor: const Color(0x3F000000),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ChangePasswordPage(),
  ));
}
