import 'dart:async';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:password_manager/profile-page.dart';
import 'package:password_manager/qr-scanner.dart';
import 'package:timezone/timezone.dart' as timezone;


class GenerateTOTPPage extends StatefulWidget {
  @override
  _GenerateTOTPPageState createState() => _GenerateTOTPPageState();
}

class _GenerateTOTPPageState extends State<GenerateTOTPPage> {
  String otp = "";
  int reloadTimer = 30; // Initial reload time in seconds for visual countdown
  Timer? countdownTimer;

  bool isHidden = true;

  // TextEditingController _textController = TextEditingController();
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
        ],
        currentIndex: 0,
        selectedItemColor: Color.fromARGB(255, 112, 175, 238),
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
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
            MaterialPageRoute(builder: (context) => UserProfilePage(),        
              ),
            );
        // Handle profile navigation
        break;
    }
  }

  void generateOTP() {
  final now = DateTime.now();
  final pacificTimeZone = timezone.getLocation('America/Los_Angeles');
  final date = timezone.TZDateTime.from(now, pacificTimeZone);
  setState(() {
    otp = OTP.generateTOTPCodeString(
      'Ishant',
      date.millisecondsSinceEpoch,
      length: 6,
      interval: 30,
      algorithm: Algorithm.SHA256,
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
          generateOTP(); // Automatically generate a new OTP
          reloadTimer = 30; // Reset reload time
        }
      });
    });
  }

  void resetReloadTimer() {
    setState(() {
      reloadTimer = 30; // Reset the reload timer to 30 seconds
    });
  }
}
