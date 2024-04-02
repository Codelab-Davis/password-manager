import 'package:flutter/material.dart';
import 'package:password_manager/home_page.dart';
import 'package:password_manager/logger.dart';
import 'package:timezone/data/latest.dart' as timezone;
import 'welcome_screen.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // Here you directly define your theme settings
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WelcomeScreen(),
    );
  }
}