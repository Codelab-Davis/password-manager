import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:password_manager/main.dart';
import 'accounts.dart';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'signup_page.dart';
import '3rd_party_signin.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

//  could you be my bodyguard?
class _LoginState extends State<Login> {
  bool checked = false;
  bool showPassword = true;
  bool showError = false;

  dynamic currentUser;

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
      currentUser = jsonDecode(response.body);
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
              children: [
                SizedBox(
                  height: getScaledSizeY(context, 15),
                ),
                Container(
                  width: getScaledSizeX(context, 185),
                  height: getScaledSizeY(context, 180),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(31),
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/paisley.jpg'), // Replace 'assets/penguin.jpeg' with the path to your image
                      fit: BoxFit.cover, // You can adjust the fit as needed
                    ),
                  ),
                ),
                SizedBox(
                  height: getScaledSizeY(context, 4),
                ),
                Text(
                  'Welcome!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF313131),
                    fontSize: getScaledSizeX(context, 40),
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                SizedBox(
                  height: getScaledSizeY(context, 30),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getScaledSizeX(context, 35),
                  ),
                  child: SizedBox(
                    height: getScaledSizeX(context, 50),
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: getScaledSizeX(context, 20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Email',
                      ),
                      controller: emailController,
                    ),
                  ),
                ),
                SizedBox(
                  height: getScaledSizeY(context, 20),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getScaledSizeX(context, 35),
                  ), // Adds padding of 20 pixels to the left and right
                  child: SizedBox(
                    height: getScaledSizeX(context, 50),
                    child: TextField(
                      obscureText: showPassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: getScaledSizeX(context, 20),
                        ),
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(showPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_rounded),
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
                ),
                SizedBox(
                  height: getScaledSizeY(context, 5),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getScaledSizeX(context, 35),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: showError,
                        child: Text(
                          "Username or Password is Invalid!",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0),
                            fontSize: getScaledSizeX(context, 15),
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getScaledSizeX(context, 22),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Theme(
                            data: ThemeData(
                              checkboxTheme: CheckboxThemeData(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  side: BorderSide(
                                    color:
                                        const Color.fromRGBO(158, 158, 158, 1),
                                    width: 0.1,
                                  ),
                                ),
                              ),
                            ),
                            child: Checkbox(
                              visualDensity: VisualDensity(
                                vertical: 0.1,
                                horizontal: 0.1,
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
                          Text(
                            'Remember Me',
                            style: TextStyle(
                              color: Color(0xFF323232),
                              fontSize: getScaledSizeX(context, 15),
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w400,
                              height: 0.06,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Color(0xFF323232),
                              fontSize: getScaledSizeX(context, 15),
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.bold,
                              height: 0.06,
                            ),
                          ),
                          SizedBox(width: getScaledSizeY(context, 10)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getScaledSizeY(context, 10),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getScaledSizeX(context, 35),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: getScaledSizeX(context, 47),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFFE4E4F9)),
                        foregroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 255, 255, 255)), // Text color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: const Color(
                                  0xFF404447), // Add thin outline color
                              width: 0.5, // Add thin outline width
                            ),
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
                                builder: (context) =>
                                    AccountsPage(user: currentUser),
                              ));
                        } else {
                          setState(() {
                            showError = true;
                          });
                        }
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Color(0xFF323232),
                          fontSize: getScaledSizeX(context, 15),
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.bold,
                          height: 0.06,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getScaledSizeY(context, 50),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: getScaledSizeX(context, 37.5), right: getScaledSizeX(context, 25)),
                        child: const Divider(),
                      ),
                    ),
                    Text("or",
                      style: TextStyle(
                        fontSize: getScaledSizeX(context, 16),
                        fontWeight: FontWeight.w500, // Make text bold
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: getScaledSizeX(context, 25), right: getScaledSizeX(context, 37.5)),
                        child: const Divider(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getScaledSizeY(context, 32),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getScaledSizeX(context, 10)), // Add horizontal padding
                      child: IconButton(
                        onPressed: () {
                          appleSignIn(context);
                        },
                        icon: Image.asset('assets/apple.png',
                            width: getScaledSizeX(context, 40), height: getScaledSizeX(context, 40)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getScaledSizeX(context, 10)), // Add horizontal padding
                      child: IconButton(
                        onPressed: () {
                          AuthMethods().signInWithGoogle(context);
                        },
                        icon: Image.asset('assets/google.png',
                            width: getScaledSizeX(context, 54), height: getScaledSizeX(context, 54)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: getScaledSizeX(context, 10)),
                      child: IconButton(
                        onPressed: () {
                          // Add your onPressed logic here
                        },
                        icon: Image.asset('assets/facebook.png',
                            width: getScaledSizeX(context, 36), height: getScaledSizeX(context, 36)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getScaledSizeY(context, 30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: getScaledSizeY(context, 10),
                      child: Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Color(0xFF323232),
                          fontSize: getScaledSizeX(context, 15),
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                          height: 0.06,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getScaledSizeY(context, 5)
                    ),
                    SizedBox(
                      width: getScaledSizeX(context, 58.5),
                      height: getScaledSizeY(context, 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signUp');
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: Color(0xFF323232),
                            fontSize: getScaledSizeX(context, 15),
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
