import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'signup_page.dart';
import '3rd_party_signin.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool checked = false;
  bool showPassword = true;

  Color getColor(Set<MaterialState> states) {
    if (checked) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 179,
                  height: 177,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(31),
                    image: DecorationImage(
                      image: AssetImage('assets/Paisley.jpeg'), // Replace 'assets/penguin.jpeg' with the path to your image
                      fit: BoxFit.cover, // You can adjust the fit as needed
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Welcome!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF313131),
                    fontSize: 40,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                      left: 20.0,
                      right:
                          20.0), // Adds padding of 20 pixels to the left and right
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Email'),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0,
                      right:
                          20.0), // Adds padding of 20 pixels to the left and right
                  child: TextField(
                    obscureText: showPassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                            () {
                              showPassword = !showPassword;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 5),
                        Theme(
                          data: ThemeData(
                            checkboxTheme: CheckboxThemeData(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    3), // Adjust the border radius if needed
                                side: BorderSide(
                                  color: Colors.grey, // Set the border color
                                  width: 0, // Adjust the border width
                                ),
                              ),
                            ),
                          ),
                          child: Checkbox(
                            visualDensity: VisualDensity(
                              vertical:
                                  0, // Adjust the vertical density to make the checkbox less thick
                              horizontal:
                                  0, // Adjust the horizontal density if needed
                            ),
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            checkColor: Colors.white,
                            value: checked,
                            onChanged: (bool? value) {
                              setState(() {
                                checked = value!;
                              });
                            },
                          ),
                        ),
                        const Text(
                          'Remember Me',
                          style: TextStyle(
                            color: Color(0xFF323232),
                            fontSize: 15,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w400,
                            height: 0.06,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color(0xFF323232),
                            fontSize: 15,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.bold,
                            height: 0.06,
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      color: Color(0xFF323232),
                      fontSize: 15,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w400,
                      height: 0.06,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 15.0),
                        child: const Divider(),
                      ),
                    ),
                    const Text("or"),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                        child: const Divider(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10), // Add horizontal padding
                      child: IconButton(
                        onPressed: () {
                          callAppleSignIn();
                        },
                        icon: Image.asset('assets/apple.png',
                            width: 40, height: 40),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10), // Add horizontal padding
                      child: IconButton(
                        onPressed: () {
                          AuthMethods().signInWithGoogle(context);
                        },
                        icon: Image.asset('assets/google.png',
                            width: 54, height: 54),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10), // Add horizontal padding
                      child: IconButton(
                        onPressed: () {
                          // Add your onPressed logic here
                        },
                        icon: Image.asset('assets/facebook.png',
                            width: 36, height: 36),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                      child: Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Color(0xFF323232),
                          fontSize: 15,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                          height: 0.06,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: 58.5,
                      height: 10,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signUp');
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: Color(0xFF323232),
                            fontSize: 15,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.bold,
                            height: 0.06,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
