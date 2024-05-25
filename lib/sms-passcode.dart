import 'dart:ui';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:password_manager/main.dart';
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
      body: Stack(
        children: <Widget>[
          Center(
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
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 345,
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Color(0xFFFFFDFC),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0x7F303030)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: SizedBox(
                              height: 46,
                              child: InternationalPhoneNumberInput(
                                inputDecoration: const InputDecoration(
                                  hintText: '000 000 0000',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFA0A0A0),
                                    fontSize: 16,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onInputChanged: (PhoneNumber number) {
                                  setState(() {
                                    this.number = number;
                                  });
                                },
                                textFieldController: controller,
                                initialValue: PhoneNumber(isoCode: 'US'),
                                selectorConfig: const SelectorConfig(
                                  selectorType: PhoneInputSelectorType.DIALOG,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SixDigitPasscodePage(),
                              ),
                            ),
                            child: const Text('Six-digit Passcode'),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getScaledSizeX(context, 35),
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: SizedBox(
                  width: double.infinity,
                  height: getScaledSizeX(context, 47),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFE4E4F9)),
                      foregroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 255, 255, 255)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: const Color(0xFF404447),
                            width: 0.5,
                          ),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6)),
                    ),
                    onPressed: null,
                    child: Text(
                      'Continue',
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
            ),
          ),
        ],
      ),
    );
  }
}
