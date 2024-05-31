import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:password_manager/main.dart';
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
        title: Text(
          'Change Password',
          style: TextStyle(
            fontSize: getScaledSizeX(context, 24),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin:EdgeInsets.only(top: getScaledSizeY(context, 50), left: getScaledSizeX(context, 25), right: getScaledSizeX(context, 25)),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: getScaledSizeX(context, 20)),
                            child: Text(
                              'Current Password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF323232),
                                fontSize: getScaledSizeX(context, 16),
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: getScaledSizeY(context, 10)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: getScaledSizeX(context, 20)),
                          child: Container(
                            decoration: ShapeDecoration(
                              color: Color(0xFFFFFDFC),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0x7F303030)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: getScaledSizeX(context, 15), right: getScaledSizeX(context, 15)),
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
                  SizedBox(height: getScaledSizeY(context, 35)),
                  Container(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: getScaledSizeX(context, 20)),
                            child: Text(
                              'New Password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF323232),
                                fontSize: getScaledSizeX(context, 16),
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: getScaledSizeY(context, 10)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: getScaledSizeX(context, 20)),
                          child: Container(
                            decoration: ShapeDecoration(
                              color: Color(0xFFFFFDFC),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0x7F303030)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding:
                                   EdgeInsets.only(left: getScaledSizeX(context, 15), right: getScaledSizeX(context, 15)),
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
                  SizedBox(height: getScaledSizeY(context, 35)),
                  Container(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: getScaledSizeX(context, 20)),
                            child: Text(
                              'Confirm Password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF323232),
                                fontSize: getScaledSizeX(context, 16),
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: getScaledSizeY(context, 10)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: getScaledSizeX(context, 20)),
                          child: Container(
                            decoration: ShapeDecoration(
                              color: Color(0xFFFFFDFC),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0x7F303030)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: getScaledSizeX(context, 15), right: getScaledSizeY(context, 15)),
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
              height: getScaledSizeY(context, 65),
            ),
            Container(
              width: getScaledSizeX(context, 140),
              height: getScaledSizeY(context, 50),
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
                                builder: (context) => const UserProfilePage()));
                      });
                      return AlertDialog(
                        title: Padding(
                          padding: EdgeInsets.only(top: getScaledSizeY(context, 20)),
                          child: Icon(
                            Icons.check_circle,
                            color: Color(0xFF374375),
                            size: 80,
                          ),
                        ),
                        content: SizedBox(
                          width: getScaledSizeX(context, 350),
                          height: getScaledSizeY(context, 80),
                          child: Text(
                            'You’ve successfully changed\n your password',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF323232),
                              fontSize: getScaledSizeX(context, 18),
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
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getScaledSizeX(context, 16),
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
