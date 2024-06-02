import 'dart:async';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:password_manager/profile-page.dart';
import 'package:password_manager/qrscanner-page.dart';
import 'package:password_manager/global.dart';
import 'package:password_manager/accounts.dart';

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
        title: const Text(
          'TOTP Generator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QRScannerPage(),
                  ),
                );
                if (result != null && result) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('OTP Generated'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              otp.isNotEmpty ? otp.substring(0, 3) + " " + otp.substring(3) : '',
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
                          ],
                        ),
                      );
                    },
                  );
                }
              },
              child: const Text('QR Scanner'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
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

