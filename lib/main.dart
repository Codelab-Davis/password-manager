import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:otp/otp.dart';
import 'package:timezone/timezone.dart' as timezone;

void main() {
  runApp(const MyApp());
  _setupLogging(); // Set up logging
}

void _setupLogging() {
  Logger.root.level = Level.ALL; // Log all levels
  Logger.root.onRecord.listen((record) {
    // Print log records to the console
    print('${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
  });
}

final Logger _logger = Logger('MyHomePageState');

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      _logger.warning('Failed to fetch data from backend with status code: ${response.statusCode}');
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

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    fetchData(); // Call fetchData here
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
            const Text('You have pushed the button this many times:'),
            Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

void generateOTP() async {
  while (true) {
    final now = DateTime.now();
    final pacificTimeZone = timezone.getLocation('America/Los_Angeles');

    final date = timezone.TZDateTime.from(now, pacificTimeZone);

    final code = OTP.generateTOTPCodeString('ISHANT', date.millisecondsSinceEpoch,
        length: 4, interval: 5, algorithm: Algorithm.SHA256, isGoogle: true);

    print("Generated OTP: $code");

    await Future.delayed(Duration(seconds: 5));
  }
}