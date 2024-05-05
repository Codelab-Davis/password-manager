import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:password_manager/profile-page.dart';


class Edit2FAPage extends StatefulWidget {
  const Edit2FAPage({Key? key}) : super(key: key);

  @override
  _Edit2FAPageState createState() => _Edit2FAPageState();
}



class _Edit2FAPageState extends State<Edit2FAPage> {
  bool isFaceID = false;
  bool isSMS = false;
  bool is6digit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
        '2FA Preference',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFaceID = !isFaceID;
                        isSMS = false;
                        is6digit = false;
                      });
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      margin: const EdgeInsets.only(top: 35),
                      decoration: BoxDecoration(
                        color: isFaceID? Color.fromARGB(255, 215, 213, 213) : Color.fromARGB(255, 255, 253, 253),
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.face_rounded,
                        color: Colors.black,
                        size: 60,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Face ID',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSMS = !isSMS;
                        isFaceID = false;
                        is6digit = false;
                      });
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      margin: const EdgeInsets.only(top: 50),
                      decoration:  ShapeDecoration(
                        color: isSMS? Color.fromARGB(255, 215, 213, 213) : Color.fromARGB(255, 255, 253, 253),
                        shape: const OvalBorder(),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.textsms_rounded,
                        color: Colors.black,
                        size: 60,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'SMS Passcode',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        is6digit = !is6digit;
                        isFaceID = false;
                        isSMS = false;
                      });
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      margin: const EdgeInsets.only(top: 50),
                      decoration:  ShapeDecoration(
                        color: is6digit? Color.fromARGB(255, 215, 213, 213) : Color.fromARGB(255, 255, 253, 253),
                        shape: const OvalBorder(),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.dialpad_rounded,
                        color: Colors.black,
                        size: 60,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      '6-Digit Passcode',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
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
                    color: Color.fromARGB(18, 0, 0, 0),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  )
                ],
              ),
              margin: const EdgeInsets.only(top: 35),
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
                            color: Color(0xFF374375),
                            size: 80,
                          ),
                        ),
                        content: SizedBox(
                          width: 350,
                          height: 50,
                          child: Text(
                            'Your two-factor authentication\n method has been changed',
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
                  'Confirm',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

