import 'dart:async';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:timezone/data/latest.dart' as timezone;
import 'package:clipboard/clipboard.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/timezone.dart' as timezone;
import 'package:logger/logger.dart';


String code = "";

void main() {
  runApp(MyApp());
  timezone.initializeTimeZones();
  generateOTP();
}

void generateOTP() async {
  while (true) {
    final now = DateTime.now();

    final pacificTimeZone = timezone.getLocation('America/Los_Angeles');

    final date = timezone.TZDateTime.from(now, pacificTimeZone);

    code = OTP.generateTOTPCodeString('ISHANT', date.millisecondsSinceEpoch,
        length: 6, interval: 5, algorithm: Algorithm.SHA256, isGoogle: true);

    await Future.delayed(const Duration(seconds: 5));
  }
}


final Logger _logger = Logger();

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
  String otp = code;

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
            FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return AlertDialog(
                        title: const Text('Passcode'),
                        content:
                            Text(otp.substring(0, 3) + " " + otp.substring(3)),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                otp = code;
                              });
                            },
                            child: const Icon(Icons.refresh),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              FlutterClipboard.copy(otp);
                            },
                            child: const Text('Copy'),
                          )
                        ],
                      );
                    },
                  ),
                );
              },
              tooltip: 'Generate OTP pop-up',
              child: const Text(
                'TOTP Pop-up',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
