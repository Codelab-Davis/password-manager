import 'dart:async';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For clipboard operations
import 'package:otp/otp.dart';
import 'package:timezone/data/latest.dart' as timezone;
import 'package:timezone/timezone.dart' as timezone;
import 'dart:convert';
import 'package:http/http.dart' as http;



void main() {
  runApp(const MyApp());
  timezone.initializeTimeZones();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter OTP Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'TOTP Display'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

postData(String email, String password) async {
  try {
    var url = Uri.http('localhost:5000', '/test/add');
    var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email, 
        'password': password,
      }),
    );
    //print('Response status: ${response.statusCode}'); //Helpful for debugging
    //print('Response body: ${response.body}'); //Helpful for debugging
  } catch(e) {
    print(e);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  bool isHidden = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Padding (
            padding: const EdgeInsets.only(left: 20.0, right: 20.0), // Adds padding of 20 pixels to the left and right
            child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), 
                  hintText: 'Enter Email:'
                  ),
                controller: emailController,
            ),
          ),
            const SizedBox(height: 10),
            Padding (
            padding: const EdgeInsets.only(left: 20.0, right: 20.0), // Adds padding of 20 pixels to the left and right
            child:
            TextField(
              obscureText: isHidden, // Use the isHidden variable here
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter Password:',
                suffixIcon: IconButton(
                  onPressed: togglePassword,
                  icon: Icon(
                    isHidden ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
              controller: passwordController,
            ),
            ),
            const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  postData(emailController.text, passwordController.text);   
              },
                child: const Text("Submit")
            ),
            const SizedBox(height: 150),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenerateTOTPPage()),
                );
              },
              child: const Text('Generate TOTP'),
            ),
          ],
        ),
      ),
    );
  }
    void togglePassword() {
    setState(() {
      isHidden = !isHidden;
    });
  }
}

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
          ],
        ),
      ),
    );
  }

  void generateOTP() {
    final now = DateTime.now();
    final pacificTimeZone = timezone.getLocation('America/Los_Angeles');
    final date = timezone.TZDateTime.from(now, pacificTimeZone);

    setState(() {
      otp = OTP.generateTOTPCodeString('ABCDEF', date.millisecondsSinceEpoch,
          length: 6, interval: 30, algorithm: Algorithm.SHA256, isGoogle: true);
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


