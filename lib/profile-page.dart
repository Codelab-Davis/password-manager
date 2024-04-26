import 'package:flutter/material.dart';
import 'package:password_manager/global.dart';
import 'package:password_manager/qrscanner-page.dart';
import 'package:password_manager/totp-page.dart';
import 'package:password_manager/passbook-page.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

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
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: const Color(0xFFD9D9D9),
              ),
            ),
            Container(
              width: 450,
              height: 650,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: const Color(0xFFD9D9D9),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 345,
        height: 59,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home, size: 35),
                onPressed: () => _onItemTapped(0, context),
              ),
              IconButton(
                icon: Icon(Icons.qr_code, size: 35),
                onPressed: () => _onItemTapped(1, context),
              ),
              IconButton(
                icon: Icon(Icons.person, size: 35),
                onPressed: () => _onItemTapped(2, context),
              ),
              IconButton(
                icon: Icon(Icons.book_sharp, size: 35),
                onPressed: () => _onItemTapped(3, context),
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
        MaterialPageRoute(builder: (context) => QRScannerPage()),
      );
      break;
    case 2:
      break;
    case 3:
      Navigator.pushReplacement(
        context as BuildContext,
        MaterialPageRoute(
          builder: (context) => const AccountsPage(),
        ),
      );

      break;
  }
}
