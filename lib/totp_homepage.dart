// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart' as timezone;

void main() {
  timezone.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PasswordManagerHomePage(),
    );
  }
}

class PasswordManagerHomePage extends StatefulWidget {
  const PasswordManagerHomePage({Key? key}) : super(key: key);

  @override
  _PasswordManagerHomePageState createState() => _PasswordManagerHomePageState();
}

class _PasswordManagerHomePageState extends State<PasswordManagerHomePage> {
  OverlayEntry? _totpOverlayEntry;
  String _otp = "";
  int _reloadTimer = 30;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    // Example Secret Key 
    String secret = 'JBSWY3DPEHPK3PXP'; 
    setState(() {
      newMethod(secret, now);
    });
    _startReloadTimer();
  }

  String newMethod(String secret, DateTime now) {
    return _otp = OTP.generateTOTPCodeString(
      secret,
      now.millisecondsSinceEpoch,
      length: 6,
      interval: 30,
      algorithm: Algorithm.SHA1,
      isGoogle: true,
    );
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void generateOTP() {
  final now = DateTime.now();
  // Example Secret key
  String secret = 'JBSWY3DPEHPK3PXP'; 
  setState(() {
    _otp = OTP.generateTOTPCodeString(
      secret,
      now.millisecondsSinceEpoch,
      length: 6,
      interval: 30,
      algorithm: Algorithm.SHA1,
      isGoogle: true,
    );
  });
}


  void _startReloadTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_reloadTimer > 0) {
          _reloadTimer--;
        } else {
          _generateOTP();
          _reloadTimer = 30;
        }
      });
    });
  }

  void _showTOTPGeneratorOverlay() {
    _totpOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.2,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "${_otp.substring(0, 3)} ${_otp.substring(3)}",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Reload in $_reloadTimer seconds',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _generateOTP();
                  },
                  child: const Text('Reload'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: _otp));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('OTP copied to clipboard')),
                    );
                  },
                  child: const Text('Copy'),
                ),
                ElevatedButton(
                  onPressed: () => _totpOverlayEntry?.remove(),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_totpOverlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: const [
          Icon(Icons.more_vert, color: Colors.black),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 32.0),
              child: Text(
                'Welcome, Olivia',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            // Rest of your UI elements
            Expanded(
  child: GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.2,
    ),
    itemCount: 6, // Number of items in the grid
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: _showTOTPGeneratorOverlay,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.security, size: 48), 
              const SizedBox(height: 10),
              Text('Account $index'), 
            ],
          ),
        ),
      );
    },
  ),
),
          ],
        ),
      ),
    );
  }
  
  void _generateOTP() {}
}
