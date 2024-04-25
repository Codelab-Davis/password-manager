import 'package:flutter/material.dart';
import 'login-page.dart';
import 'dart:async';


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State
{
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const Login(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(188, 188, 224, 1),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icon.png',
                  width: 240,
                  height: 230,
                ),
                Container(
                  //margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: const Text(
                    'PassPal',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF313131),
                      fontSize: 40,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}