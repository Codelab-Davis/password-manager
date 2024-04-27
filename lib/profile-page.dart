
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:password_manager/edit_account-page.dart';
import 'package:password_manager/global.dart';
import 'package:password_manager/qrscanner-page.dart';
import 'package:password_manager/splash-page.dart';
import 'package:password_manager/totp-page.dart';
import 'package:password_manager/passbook-page.dart';


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
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 167,
              height: 167,
              margin: const EdgeInsets.only(top: 80),
              decoration: const ShapeDecoration(
                color: Color(0xFFD9D9D9),
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
                color: Color(0xFFEFEFEF),
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
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20,left: 40),
                          child: Text(
                            'First Last',
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
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, right: 20),
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfilePage(),
                              ),
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        'janedoe@gmail.com',
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
                      width: 313,
                      height: 55,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFD9D9D9),
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
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          shadowColor: const Color(0x3F000000),
                        ),
                        child: const Text(
                          'Change Password',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w400,
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
                      width: 313,
                      height: 55,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFD9D9D9),
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
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          shadowColor: const Color(0x3F000000),
                        ),
                        child: const Text(
                          'Edit 2FA Preferences',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w400,
                            height: 0.04,
                          ),
                        ),
                      ),
                    ),
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 40, left: 10),
                          child: Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w400,
                            height: .06,
                          ),
                          ),
                        ),
                        ),
                        Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: IconButton(
                          icon: Icon(Icons.exit_to_app_rounded),
                          iconSize: 20,
                          color: Colors.black,
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  SplashPage(),
                          ),
                        ),
                        )
                        ),
                        ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 345,
        height: 59,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: 35,
                  color: _selectedIndex == 0 ? Colors.blue : null,
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                  _onItemTapped(0, context);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.qr_code,
                  size: 35,
                  color: _selectedIndex == 1 ? Colors.blue : null,
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                  _onItemTapped(1, context);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.key_sharp,
                  size: 35,
                  color: _selectedIndex == 2 ? Colors.blue : null,
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                  _onItemTapped(2, context);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  size: 35,
                  color: _selectedIndex == 3 ? Colors.blue : null,
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                  _onItemTapped(3, context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


void _onItemTapped(int index, BuildContext context) {
  switch (index) {
    case 0:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                GenerateTOTPPage(secret: Global.result?.code ?? '')),
      );
      break;
    case 1:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const QRScannerPage()),
      );
      break;
    case 3:
      break;
    case 2:
      Navigator.pushReplacement(
        context as BuildContext,
        MaterialPageRoute(
          builder: (context) => const AccountsPage(user: null,),
        ),
      );

      break;
  }
}
