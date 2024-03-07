import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:otp/otp.dart';
import 'package:timezone/timezone.dart' as timezone;
import 'package:timezone/data/latest.dart' as timezone;
import 'package:clipboard/clipboard.dart';
import 'dart:convert';

String code = "";

void main() {
  runApp(const MyApp());
  timezone.initializeTimeZones();
  _setupLogging(); // Set up logging
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

void _setupLogging() {
  Logger.root.level = Level.ALL; // Log all levels
  Logger.root.onRecord.listen((record) {
    // Print log records to the console
    print(
        '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
  });
}

final Logger _logger = Logger('MyHomePageState');

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

void fetchData() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:5000/test/'));
    if (response.statusCode == 200) {
      _logger.info('Data from backend: ${response.body}');
    } else {
      _logger.warning(
          'Failed to fetch data from backend with status code: ${response.statusCode}');
    }
  } catch (e) {
    _logger.severe('Failed to fetch data: $e');
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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
  
  TextEditingController _textController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), 
                  hintText: 'Enter Email:'
                  ),
                controller: emailController,
                ),
              SizedBox(height: 10), // Add spacing between the TextField and the FloatingActionButton
              TextField(
                obscureText: isHidden,
                decoration: InputDecoration(
                  border: OutlineInputBorder(), 
                  hintText: 'Enter Password:',
                  suffixIcon: togglePassword()
                  ),
                controller: passwordController,
                ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  postData(emailController.text, passwordController.text);   
              },
                child: Text("Submit")),
              SizedBox(height: 150),
              FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return AlertDialog(
                          title: const Text('Passcode'),
                          content: Text(code.substring(0, 3) + " " + code.substring(3)),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                });
                              },
                              child: const Icon(Icons.refresh),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                FlutterClipboard.copy(code);
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
      ),
    );
  }

  Widget togglePassword() {
    return IconButton(onPressed: (){
      setState(() {
        isHidden = !isHidden;        
      });
    }, icon: isHidden ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined),
    color: Colors.grey,);
  }
}


