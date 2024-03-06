import 'dart:async';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:timezone/data/latest.dart' as timezone;
import 'package:clipboard/clipboard.dart';
import 'package:timezone/timezone.dart' as timezone;

void main() {
  runApp(MyApp());
  timezone.initializeTimeZones();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenerateTOTPPage()),
                );
              },
              child: Text('Generate TOTP'),
            ),
          ],
        ),
      ),
    );
  }
}

class GenerateTOTPPage extends StatefulWidget {
  @override
  _GenerateTOTPPageState createState() => _GenerateTOTPPageState();
}

class _GenerateTOTPPageState extends State<GenerateTOTPPage> {
  late String otp;
  late int reloadTimer;

  @override
  void initState() {
    super.initState();
    reloadTimer = 30; // Initial reload time in seconds
    generateOTP();
    startReloadTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TOTP Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Generated TOTP:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              otp.substring(0, 3) + " " + otp.substring(3),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Reload in $reloadTimer seconds',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  generateOTP();
                  reloadTimer = 30; // Reset reload time
                });
              },
              child: Text('Reload'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                FlutterClipboard.copy(otp);
              },
              child: Text('Copy'),
            ),
          ],
        ),
      ),
    );
  }

  void generateOTP() {
    final now = DateTime.now();
    final pacificTimeZone = timezone.getLocation('America/Los_Angeles');
    final date = timezone.TZDateTime.from(now, pacificTimeZone);

    otp = OTP.generateTOTPCodeString('ABCDEF', date.millisecondsSinceEpoch,
        length: 6, interval: 30, algorithm: Algorithm.SHA256, isGoogle: true);
  }

  void startReloadTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (reloadTimer > 0) {
          reloadTimer--;
        }
      });
    });
  }
}
