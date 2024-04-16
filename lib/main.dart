import 'package:flutter/material.dart';
import 'package:password_manager/logger.dart';
import 'package:timezone/data/latest.dart' as timezone;
import 'welcome_screen.dart';
import 'home_page.dart';

void main() {
  timezone.initializeTimeZones();
  setupLogging();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/signUp': (context) => const MyHomePage(title: "Sign Up"),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WelcomeScreen(),
    );
  }
}