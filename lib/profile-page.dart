import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:password_manager/accounts.dart';
import 'package:password_manager/change_password-page.dart';
import 'package:password_manager/edit_2fa-page.dart';
import 'package:password_manager/edit-profile-page.dart';
import 'package:password_manager/global.dart';
import 'package:password_manager/qrscanner-page.dart';
import 'package:password_manager/splash-page.dart';
import 'package:password_manager/totp-page.dart';


class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  int _selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBCBCE0),
      appBar: AppBar(
        backgroundColor: Color(0xFFBCBCE0),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 167,
              height: 167,
              margin: const EdgeInsets.only(top: 80),
              decoration: const ShapeDecoration(
                color: Color(0xFFCADCFF),
                shape: OvalBorder(),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 69),
              width: MediaQuery.of(context).size.width,
              height: 500,
              decoration: const ShapeDecoration(
                color: Color(0xFFFFFBFB),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                )),
                shadows: [
                  BoxShadow(
                    color: Color(0xFFA3A3A3),
                    blurRadius: 8,
                    offset: Offset(2, 4),
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 50, left: 55),
                          child: Text(
                            'Paisley Penguin',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w700,
                              height: 0.06,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 25, left: 55),
                      child: Text(
                        'paiselypenguin@gmail.com',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w300,
                          height: 0.06,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 40, right: 40),
                    child: Container(
                      width: 330,
                      height: 55,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Color(0xFFE4E4F9),
                        shadows: const [
                          BoxShadow(
                            color: Color.fromARGB(18, 0, 0, 0),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          surfaceTintColor: Color(0xFFE4E4F9),
                          foregroundColor: Color(0xFFE4E4F9),
                          backgroundColor: Color(0xFFE4E4F9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                        ),
                        child: const Text(
                          'Account Settings',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w500,
                            height: 0.04,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 40, right: 40),
                    child: Container(
                      width: 330,
                      height: 55,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.white,
                        shadows: const [
                          BoxShadow(
                            color: Color.fromARGB(18, 0, 0, 0),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePasswordPage(),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          surfaceTintColor: Color(0xFFE4E4F9),
                          foregroundColor: Color(0xFFE4E4F9),
                          backgroundColor: Color(0xFFE4E4F9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                        ),
                        child: const Text(
                          'Change Password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w500,
                            height: 0.04,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 40, right: 40),
                    child: Container(
                      width: 330,
                      height: 55,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.white,
                        shadows: const [
                          BoxShadow(
                            color: Color.fromARGB(18, 0, 0, 0),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WelcomeScreen(),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          surfaceTintColor: Color(0xFFE4E4F9),
                          foregroundColor: Color(0xFFE4E4F9),
                          backgroundColor: Color(0xFFE4E4F9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w500,
                                height: 0.04,
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(
                              Icons.logout_outlined,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      
    );
  }
}