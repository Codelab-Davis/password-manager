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
  int _selectedIndex = 0;
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
            builder: (context) => const AccountsPage(),
          ),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context as BuildContext,
          MaterialPageRoute(
            builder: (context) => const UserProfilePage(),
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
