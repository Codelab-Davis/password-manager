import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For clipboard operations
import 'package:otp/otp.dart';
import 'package:timezone/timezone.dart' as timezone;


String code = "";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String otp = code;

  @override
  void initState() {
    super.initState();
    generateOTP();
  }
  
void generateOTP() async {
  while (true) { // Ensure loop continues only while widget is mounted
    final now = DateTime.now();
    final pacificTimeZone = timezone.getLocation('America/Los_Angeles');
    final date = timezone.TZDateTime.from(now, pacificTimeZone);

    final newCode = OTP.generateTOTPCodeString('ISHANT', date.millisecondsSinceEpoch,
        length: 6, interval: 1, algorithm: Algorithm.SHA256, isGoogle: true);

    setState(() {
      code = newCode; // Update the global 'code' variable
      otp = code; // Ensure 'otp' is updated with the new code, triggering a widget update
    });

    await Future.delayed(const Duration(seconds: 1)); // Wait for the next interval before updating
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Passcode'),
                    content: Text(otp.substring(0, 3) + " " + otp.substring(3)),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          otp = code;
                        },
                        child: const Icon(Icons.refresh),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: otp));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('OTP copied to clipboard')),
                          );
                        },
                        child: const Text('Copy'),
                      ),
                    ],
                  ),
                );
              },
              tooltip: 'Generate OTP',
              child: const Text(
                'Generate OTP',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
