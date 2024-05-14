import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'accounts.dart';
import 'dart:convert';
import 'global.dart';
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
  bool showError = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Color getColor(Set<MaterialState> states) {
    if (checked) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  Future<bool> verifyCredentials(String email, String password) async {
    try {
      final queryParameters = {'email': email, 'password': password};
      final uri =
          Uri.http('localhost:5000', '/test/:email/:password', queryParameters);
      final response = await http.get(uri);
      if (response.body == "[]") {
        return false;
      }
      Global.user = jsonDecode(response.body);
      return true;
    } catch (e) {
      return false;
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
                      image: AssetImage('assets/paisley.jpg'), // Replace 'assets/penguin.jpeg' with the path to your image
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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0,
                      right:
                          20.0), // Adds padding of 20 pixels to the left and right
                  child: SizedBox(
                    child: TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Email'),
                      controller: emailController,
                    ),
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
                      border: const OutlineInputBorder(),
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
                    controller: passwordController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: showError,
                        child: const Text(
                          "Username or Password is Invalid!",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0),
                            fontSize: 15,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 220, 220, 220)),
                        foregroundColor: MaterialStateProperty.all(
                            const Color(0xFF404447)), // Text color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            // BorderRadius
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6)),
                      ),
                      onPressed: () async {
                        if (await verifyCredentials(
                            emailController.text, passwordController.text)) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccountsPage(user: Global.user),
                              ));
                        } else {
                          setState(() {
                            showError = true;
                          });
                        }
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          color: Color(0xFF323232),
                          fontSize: 15,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                          height: 0.06,
                        ),
                      ),
                    ),
                  ),
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
                          appleSignIn(context);
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
