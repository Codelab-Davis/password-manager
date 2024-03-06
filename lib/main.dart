import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:timezone/data/latest.dart' as timezone;
import 'package:clipboard/clipboard.dart';
import 'package:timezone/timezone.dart' as timezone;
import 'package:logger/logger.dart';

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

  @override
  void initState() {
    super.initState();
    generateOTP();
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
            ElevatedButton(
              onPressed: () {
                setState(() {
                  generateOTP();
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

    otp = OTP.generateTOTPCodeString('ISHANT', date.millisecondsSinceEpoch,
        length: 6, interval: 5, algorithm: Algorithm.SHA256, isGoogle: true);
  }
}
