// ignore: file_names
import 'package:flutter/material.dart';
import 'package:password_manager/global.dart';
import 'package:password_manager/qrscanner-page.dart';
import 'package:password_manager/totp-page.dart';
import 'package:password_manager/passbook-page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
          ],
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
        context,
        MaterialPageRoute(
          builder: (context) => const AccountsPage(user: null,),
        ),
      );

      break;
  }
}
