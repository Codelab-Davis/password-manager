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
          children: const <Widget>[
            Text(
              'User Profile Page',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), // Corrected icon for the fourth option
            label: 'Settings', // Label for the new fourth button
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Color.fromARGB(255, 112, 175, 238),
        unselectedItemColor: Colors.grey, 
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }
}

void _onItemTapped(int index, BuildContext context) {
  switch (index) {
    case 0:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GenerateTOTPPage(secret: Global.result?.code ??'')),
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
            MaterialPageRoute(builder: (context) => const AccountsPage(user: ''),        
              ),
            );

      break;
  }
}
