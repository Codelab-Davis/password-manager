import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:password_manager/logger.dart';
import 'package:password_manager/splash-page.dart';
import 'package:timezone/data/latest.dart' as timezone;
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'firebase_options.dart';
import 'signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  timezone.initializeTimeZones();
  setupLogging();
  await Firebase.initializeApp(
  name: 'passpal-614b0',
  options: DefaultFirebaseOptions.currentPlatform,
);
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
        useMaterial3: true,
      ),
      home: WelcomeScreen(),
      
    );
  }
}

double getScaledSizeX(BuildContext context, double desiredSize) {
  const double screenWidth = 430; //1290 pixels
  
  double factor = screenWidth / desiredSize;

  return MediaQuery.of(context).size.width/factor;
}

double getScaledSizeY(BuildContext context, double desiredSize) {
  const double screenHeight = 932;
  
  double factor = screenHeight / desiredSize;

  return MediaQuery.of(context).size.height/factor;
}

