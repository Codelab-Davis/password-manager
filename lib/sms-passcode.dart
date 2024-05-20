import 'dart:ui';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:password_manager/six-digit-passcode.dart';

class SMSPasscodePage extends StatefulWidget {
  const SMSPasscodePage({Key? key}) : super(key: key);

  @override
  _SMSPasscodePageState createState() => _SMSPasscodePageState();
}

class _SMSPasscodePageState extends State<SMSPasscodePage> {
  final TextEditingController controller = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  bool isValid = false;
  PhoneNumber? validPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 400, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 275,
                    child: Text(
                      'Registration',
                      style: TextStyle(
                        color: Color(0xFF313131),
                        fontSize: 25,
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    child: Text(
                      'Enter your phone number for SMS passcode\ntwo-factor authentication',
                      style: TextStyle(
                        color: Color(0xFF323232),
                        fontSize: 16,
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w400,
                        height: 1.1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Align the input to the start
                    children: [
                      SizedBox(
                        width: 350,
                        child: InternationalPhoneNumberInput(
                          inputDecoration: InputDecoration(
                            hintText: '000 000 0000',
                            hintStyle: TextStyle(
                              color: Color(0xFFA0A0A0),
                              fontSize: 16,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w400,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.red, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                          ),
                          onInputChanged: (PhoneNumber number) {
                            setState(() {
                              this.number = number;
                            });
                          },
                          textFieldController: controller,
                          initialValue: PhoneNumber(isoCode: 'US'),
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SixDigitPasscodePage()),
                    );
                  },
                  child: const Text('Sign Up Stuff'),
                ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
