import 'package:flutter/material.dart';
import 'home_page.dart';
import 'accounts.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 179,
                  height: 177,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(31),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: const Text(
                    'PASSPAL>',
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
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: const Text(
                          'Providing extra security for',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF323232),
                            fontSize: 18,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w400,
                            height: 0.06,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        child: const Text(
                          'your passwords using 2FA',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF323232),
                            fontSize: 18,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w400,
                            height: 0.06,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 139,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        // switch to accounts page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFD9D9D9), // Background color
                        foregroundColor: const Color(0xFF323232), // Text color
                        elevation: 6, // Elevation
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15), // BorderRadius
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6), // Padding
                        shadowColor: const Color(0x3F000000), // Shadow color
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 139,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button click action here
                        // For example, navigate to another screen or execute a function
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyHomePage(title: "Sign Up")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFD9D9D9), // Background color
                        foregroundColor: const Color(0xFF323232), // Text color
                        elevation: 6, // Elevation
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15), // BorderRadius
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6), // Padding
                        shadowColor: const Color(0x3F000000), // Shadow color
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
