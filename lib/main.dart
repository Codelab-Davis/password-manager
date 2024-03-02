import 'dart:async';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:timezone/data/latest.dart' as timezone;
import 'package:timezone/timezone.dart' as timezone;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TOTP Display',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer _timer;
  late String _otp;
  late int _countdown;

  @override
  void initState() {
    super.initState();
    timezone.initializeTimeZones();

    _countdown = 30; // Set your TOTP interval here

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final pacificTimeZone = timezone.getLocation('America/Los_Angeles');
      final now = DateTime.now();
      final date = timezone.TZDateTime.from(now, pacificTimeZone);

      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _otp = generateTOTP('ABCDE', date.millisecondsSinceEpoch);
          _countdown = 30; // Reset the countdown after each TOTP generation
        }
      });
    });

    // Initial TOTP generation
    _otp = generateTOTP('ABCDE', DateTime.now().millisecondsSinceEpoch);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String generateTOTP(String secret, int timestamp) {
    return OTP.generateTOTPCodeString(
      secret,
      timestamp,
      length: 6,
      interval: 30, // Set your TOTP interval here
      algorithm: Algorithm.SHA256,
      isGoogle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TOTP Display'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'TOTP:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              _otp,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Time until reset: $_countdown seconds',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
