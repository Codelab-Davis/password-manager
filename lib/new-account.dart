import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/accounts.dart';
import 'package:otp/otp.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clipboard/clipboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewAccount extends StatefulWidget {
  final dynamic user;
  final dynamic addAccount;
  const NewAccount({super.key, required this.user, required this.addAccount});

  @override
  State<NewAccount> createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  bool showPassword = false;
  bool enableOtp = false;

  TextEditingController appNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  Timer? _debounce;

  String currAppName = "";

  // TOTP related variables
  String otp = "";
  int reloadTimer = 30;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    appNameController.addListener(updateCurrAppName);
  }

  @override
  void dispose() {
    appNameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    notesController.dispose();
    _debounce?.cancel();
    countdownTimer?.cancel();
    super.dispose();
  }

  void updateCurrAppName() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(seconds: 1),
      () {
        setState(() {
          currAppName = appNameController.text;
        });
      },
    );
  }

  void generateOTP() {
    final now = DateTime.now();
    setState(() {
      otp = OTP.generateTOTPCodeString(
        "YourSecretKeyHere",
        now.millisecondsSinceEpoch,
        length: 6,
        interval: 30,
        algorithm: Algorithm.SHA1,
        isGoogle: true,
      );
    });
  }

  void startReloadTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (reloadTimer > 0) {
          reloadTimer--;
        } else {
          generateOTP();
          reloadTimer = 30;
        }
      });
    });
  }

  void resetReloadTimer() {
    setState(() {
      reloadTimer = 30;
    });
  }

  void toggleOtpGeneration(bool value) {
    setState(() {
      enableOtp = value;
      if (enableOtp) {
        generateOTP();
        startReloadTimer();
      } else {
        countdownTimer?.cancel();
        otp = "";
      }
    });
  }

  void updateUser(String appName, String username, String password, String notes) async {
    final id = widget.user[0]['_id'];
    var url = Uri.http('172.16.40.41:5001', '/test/updateAccounts/$id');
    final account = jsonEncode({
      'appName': appName,
      'username': username,
      'password': password,
      'notes': notes,
    });
    try {
      await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: account,
      );
      widget.addAccount(appName, username, password, notes);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EDEC),
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountsPage(user: widget.user)),
                );
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: ShapeDecoration(
                color: const Color(0xFFFFFBFB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              height: MediaQuery.of(context).size.height - 150,
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(40, 50, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Application Name',
                        style: TextStyle(
                          color: Color(0xFF313131),
                          fontSize: 16,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        controller: appNameController,
                        style: const TextStyle(
                          color: Color(0xFF323232),
                          fontSize: 15,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: 'Enter application name',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20)),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(40, 20, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Username',
                        style: TextStyle(
                          color: Color(0xFF313131),
                          fontSize: 16,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: usernameController,
                        style: const TextStyle(
                          color: Color(0xFF323232),
                          fontSize: 15,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: 'Enter username',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20)),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(40, 20, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Password',
                        style: TextStyle(
                          color: Color(0xFF313131),
                          fontSize: 16,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: passwordController,
                        style: const TextStyle(
                          color: Color(0xFF323232),
                          fontSize: 15,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                        obscureText: showPassword,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: 'Enter password',
                            suffixIcon: SizedBox(
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      constraints:
                                          const BoxConstraints(maxWidth: 15),
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
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        FlutterClipboard.copy(
                                                passwordController.text)
                                            .then((_) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Password copied to clipboard'),
                                            ),
                                          );
                                        });
                                      },
                                      icon: const Icon(Icons.copy),
                                    ),
                                  ]),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20)),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(40, 20, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Notes',
                        style: TextStyle(
                          color: Color(0xFF313131),
                          fontSize: 16,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: SizedBox(
                      height: 100,
                      child: TextField(
                        controller: notesController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        expands: true,
                        style: const TextStyle(
                          color: Color(0xFF323232),
                          fontSize: 15,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: 'Enter notes',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20)),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(40, 20, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enable OTP',
                        style: TextStyle(
                          color: Color(0xFF313131),
                          fontSize: 16,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      ),
                    ),
                  ),
                  Switch(
                    value: enableOtp,
                    onChanged: toggleOtpGeneration,
                  ),
                  if (enableOtp)
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: Column(
                        children: [
                          const Text(
                            'OTP',
                            style: TextStyle(
                              color: Color(0xFF313131),
                              fontSize: 16,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w400,
                              height: 0.12,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  otp,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  FlutterClipboard.copy(otp).then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('OTP copied to clipboard'),
                                      ),
                                    );
                                  });
                                },
                                icon: const Icon(Icons.copy),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Regenerating in $reloadTimer seconds',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 40,
            right: 40,
            child: SizedBox(
              width: 370,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
                onPressed: () {
                  updateUser(appNameController.text, usernameController.text,
                      passwordController.text, notesController.text);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountsPage(user: widget.user)),
                  );
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
