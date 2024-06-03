import 'dart:async';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:password_manager/profile-page.dart';
import 'package:password_manager/qrscanner-page.dart';
import 'package:password_manager/global.dart';
import 'package:password_manager/accounts.dart';

class GenerateTOTPPage extends StatefulWidget {
  final String secret;

  const GenerateTOTPPage({Key? key, required this.secret}) : super(key: key);

  @override
  _GenerateTOTPPageState createState() => _GenerateTOTPPageState();
}

class _GenerateTOTPPageState extends State<GenerateTOTPPage> {
  String otp = "";
  int reloadTimer = 30;
  Timer? countdownTimer;
  bool isOTPToggled = false;

  @override
  void initState() {
    super.initState();
    generateOTP();
    startReloadTimer();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
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
                      builder: (context) => AccountsPage(user: Global.user)),
                );
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                decoration: ShapeDecoration(
                  color: const Color(0xFFFFFBFB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                margin: const EdgeInsets.only(top: 150),
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(40, 30, 0, 0),
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
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: SizedBox(
                        height: 45,
                        child: TextField(
                          controller:
                              TextEditingController(), // Placeholder controller
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
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller:
                              TextEditingController(), // Placeholder controller
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
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller:
                              TextEditingController(), // Placeholder controller
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
                              hintText: 'Enter password',
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
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: SizedBox(
                        height: 150,
                        child: TextField(
                          controller:
                              TextEditingController(), // Placeholder controller
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
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
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const QRScannerPage(),
                                ),
                              );

                              // Log result for debugging
                              print('QR Scan result: $result');

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(40),
                                      ),
                                    ),
                                    child: Container(
                                      decoration: const ShapeDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment(0.00, -1.00),
                                          end: Alignment(0, 1),
                                          colors: [
                                            Color(0xFF374375),
                                            Color(0xFF9292CA)
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            bottomRight: Radius.circular(40),
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'TOTP Generated',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 20),
                                            Text(
                                              otp.isNotEmpty
                                                  ? otp.substring(0, 3) +
                                                      " " +
                                                      otp.substring(3)
                                                  : '',
                                              style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child:
                                const Text('Enable Timed One-Time Password?'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
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
                          // Save
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
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
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
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
                          // Cancel
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cancel),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
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
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 140,
            left: MediaQuery.of(context).size.width / 2 - 55,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black, // Color of the border
                  width: 2, // Thickness of the border
                ),
                borderRadius:
                    BorderRadius.circular(15), // Radius of the rounded corners
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
