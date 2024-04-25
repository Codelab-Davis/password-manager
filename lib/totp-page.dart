import 'dart:async';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:password_manager/profile-page.dart';
import 'package:password_manager/qrscanner-page.dart';
import 'package:password_manager/passbook-page.dart';


class GenerateTOTPPage extends StatefulWidget {
  final String secret;

  const GenerateTOTPPage({Key? key, required this.secret}) : super(key: key);

  @override
  _GenerateTOTPPageState createState() => _GenerateTOTPPageState();
}

class _GenerateTOTPPageState extends State<GenerateTOTPPage> {
  String otp = "";
  int reloadTimer = 30; 
  Timer? countdownTimer;

  bool isHidden = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    generateOTP();
    startReloadTimer();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TOTP Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Generated TOTP:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              otp.substring(0, 3) + " " + otp.substring(3),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Reload in $reloadTimer seconds',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                generateOTP();
                resetReloadTimer();
              },
              child: const Text('Reload'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                FlutterClipboard.copy(otp).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('OTP copied to clipboard')),
                  );
                });
              },
              child: const Text('Copy'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedLabelStyle: TextStyle(fontSize: 0.001), 
            unselectedLabelStyle: TextStyle(fontSize: 0.001), 
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 35),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.qr_code, size: 35),
                label: 'Scanner',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 35),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book_sharp, size: 35),
                label: 'Book',
              ),
            ],
            currentIndex: 0,
            selectedItemColor: const Color.fromARGB(255, 112, 175, 238),
            unselectedItemColor: Colors.grey,
            onTap: (index) => _onItemTapped(index, context),
            elevation: 8,
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushReplacement(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => QRScannerPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context as BuildContext,
          MaterialPageRoute(
            builder: (context) => const UserProfilePage(),
          ),
        );
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

  void generateOTP() {
  final now = DateTime.now();
  
  setState(() {
    otp = OTP.generateTOTPCodeString(
      widget.secret,
      now.millisecondsSinceEpoch,
      length: 6,
      interval: 30,
      algorithm: Algorithm.SHA1,
      isGoogle: true,
    );
  });
}


  void startReloadTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (reloadTimer > 0) {
          reloadTimer--;
        } else {
          generateOTP(); 
          reloadTimer = 30; 
        }
      });
    });
  }

  void resetReloadTimer() {
    setState(() {
      reloadTimer = 30; 
    });
  }
}
