import 'package:flutter/material.dart';
import 'home_page.dart';
import 'sign_up_options.dart';
import 'login.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
<<<<<<< HEAD
                children: [
                  Container(
                    width: 179,
                    height: 177,
                    decoration: ShapeDecoration(
                      color: Color(0xFFD9D9D9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(31),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: const Text(
                      'APP NAME',
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
                        SizedBox(height: 20),
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
                      ],
                    ),
                  ),
                ],
=======
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
                    'APP NAME',
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
                const Column(
                  children: [
                    Text(
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
                    SizedBox(height: 20),
                    Text(
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
                  ],
                ),
              ],
>>>>>>> main
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Login()),
                        );
                        // Handle button click action here
                        // For example, navigate to another screen or execute a function
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD9D9D9), // Background color
                        foregroundColor: Color(0xFF323232), // Text color
                        elevation: 6, // Elevation
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15), // BorderRadius
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6), // Padding
                        shadowColor: const Color(0x3F000000), // Shadow color
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
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
<<<<<<< HEAD
                          MaterialPageRoute(builder: (context) => const SignUpOptions(title: "Sign Up")),
=======
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MyHomePage(title: "Sign Up")),
>>>>>>> main
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD9D9D9), // Background color
                        foregroundColor: Color(0xFF323232), // Text color
                        elevation: 6, // Elevation
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15), // BorderRadius
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6), // Padding
                        shadowColor: const Color(0x3F000000), // Shadow color
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
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
