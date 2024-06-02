import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp/otp.dart';
import 'package:password_manager/accounts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clipboard/clipboard.dart';
import 'package:password_manager/global.dart';
import 'dart:async';
import 'package:password_manager/qrscanner-page.dart';

class NewAccount extends StatefulWidget {
  final dynamic user;
  final dynamic addAccount;
  final String secret;
  const NewAccount(
      {super.key,
      required this.user,
      required this.addAccount,
      required this.secret});

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

  void updateUser(
      String appName, String username, String password, String notes) async {
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
  void dispose() {
    appNameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    notesController.dispose();
    countdownTimer?.cancel();
    _debounce?.cancel();
    super.dispose();
  }

  //TOTP STUFF

  String otp = "";
  int reloadTimer = 30;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    generateOTP();
    startReloadTimer();
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
                        onChanged: (text) async {
                          if (_debounce?.isActive ?? false) _debounce?.cancel();
                          _debounce = Timer(
                            const Duration(seconds: 1),
                            () {
                              setState(() {
                                currAppName = text;
                              });
                            },
                          );
                        },
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
                        'Additional Notes',
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
                      height: 200,
                      child: TextField(
                        controller: notesController,
                        style: const TextStyle(
                          color: Color(0xFF323232),
                          fontSize: 15,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                        ),
                        keyboardType: TextInputType.multiline,
                        minLines: 6,
                        maxLines: 6,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: 'Insert notes...',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Enable Timed One-Time Password?',
                          style: TextStyle(
                            color: Color(0xFF313131),
                            fontSize: 14,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Switch(
                          value: enableOtp,
                          onChanged: (value) {
                            setState(() {
                              enableOtp = value;
                            });
                            Future<void> scanQR() async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QRScannerPage(
                                      addAccount: widget.addAccount,
                                    )),
                              );
                              if (result != null && result) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('OTP Generated'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            otp.isNotEmpty
                                                ? otp.substring(0, 3) +
                                                    " " +
                                                    otp.substring(3)
                                                : '',
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            'Reload in $reloadTimer seconds',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(height: 20),
                                          ElevatedButton(
                                            onPressed: () {
                                              generateOTP();
                                              resetReloadTimer();
                                            },
                                            child: const Text('Reload'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }

                              scanQR();
                            }
                          },
                          activeTrackColor: const Color(
                              0xFF374375), // Background color when switch is on
                          activeColor: const Color(
                              0xFFE4E4F9), // Circle color when switch is on
                          inactiveTrackColor: Colors
                              .white, // Background color when switch is off
                          inactiveThumbColor: const Color(
                              0xFF374375), // Circle color when switch is off
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 80,
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFFE4E4F9),
                        ),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6)),
                      ),
                      onPressed: () {
                        updateUser(
                            appNameController.text,
                            usernameController.text,
                            passwordController.text,
                            notesController.text);
                        Navigator.pop(context, widget.user[0]['accounts']);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/confirm_changes.svg'),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Confirm Changes',
                            style: TextStyle(
                              color: Color(0xFF313131),
                              fontSize: 16,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w500,
                              height: 0.12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 80,
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFFE4E4F9),
                        ),
                        foregroundColor: MaterialStateProperty.all(
                            Colors.black), // Text color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6)),
                      ),
                      onPressed: () {
                        Navigator.pop(context, widget.user[0]['accounts']);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/delete_entry.svg'),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Delete Entry',
                            style: TextStyle(
                              color: Color(0xFF313131),
                              fontSize: 16,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w500,
                              height: 0.12,
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
          Positioned(
            top: 70,
            left: MediaQuery.of(context).size.width / 2 -
                50, // Center the box horizontally
            child: SizedBox(
              width: 100, // Increase the width to 150
              height: 100,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors
                            .black, // Color of the borderhickness of the border
                      ),
                      borderRadius: BorderRadius.circular(
                          15), // Radius of the rounded corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        'https://logo.clearbit.com/${currAppName.replaceAll(' ', '')}.com', // URL of the image
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          // You can return any widget here to display in case of an error
                          return Container();
                        },
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

  void generateOTP() {
    final now = DateTime.now();
    setState(() {
      otp = OTP.generateTOTPCodeString(
        widget.secret,
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
}
