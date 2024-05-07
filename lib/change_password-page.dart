import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:password_manager/profile-page.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController CurrentPassword = TextEditingController();
  TextEditingController NewPassword = TextEditingController();
  TextEditingController ConfirmPassword = TextEditingController();
  bool showCurrentPassword = true;
  bool showNewPassword = true;
  bool showConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, left: 25, right: 25),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Current Password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF323232),
                                fontSize: 16,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
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
                                      setState(
                                        () {
                                          showCurrentPassword =
                                              !showCurrentPassword;
                                        },
                                      );
                                    },
                                  ),
                                ),
                                controller: CurrentPassword,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 55),
                  Container(
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              'New Password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF323232),
                                fontSize: 16,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: TextField(
                                obscureText: showNewPassword,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'New Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(showCurrentPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(
                                          () {
                                            showNewPassword = !showNewPassword;
                                          },
                                        );
                                      },
                                    )),
                                controller: NewPassword,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 55),
                  Container(
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Confirm Password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF323232),
                                fontSize: 16,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
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
                                        setState(
                                          () {
                                            showConfirmPassword =
                                                !showConfirmPassword;
                                          },
                                        );
                                      },
                                    )),
                                controller: ConfirmPassword,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 65,
            ),
            Container(
              width: 140,
              height: 50,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
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
                                builder: (context) => const UserProfilePage()));
                      });
                      return const AlertDialog(
                        title: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.grey,
                            size: 80,
                          ),
                        ),
                        content: SizedBox(
                          width: 350,
                          height: 50,
                          child: Text(
                            'You’ve successfully changed\n your password',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  surfaceTintColor: Color(0xFFD9D9D9),
                  foregroundColor: Color(0xFFD9D9D9),
                  backgroundColor: Color(0xFFD9D9D9),
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
                    height: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
