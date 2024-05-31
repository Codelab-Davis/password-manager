import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/widgets.dart';
import 'package:password_manager/main.dart';

class SixDigitPasscodePage extends StatefulWidget {
  const SixDigitPasscodePage({Key? key}) : super(key: key);

  @override
  _SixDigitPasscodePageState createState() => _SixDigitPasscodePageState();
}

class _SixDigitPasscodePageState extends State<SixDigitPasscodePage> {
  final TextEditingController pinController = TextEditingController();

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
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getScaledSizeX(context, 16),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
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
                      SizedBox(
                        child: Text(
                          'Enter your six digit passcode for two-factor\nauthentication',
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
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getScaledSizeX(context, 16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: SizedBox(
                          width: double.infinity,
                          height: getScaledSizeX(context, 78),
                          child: PinCodeTextField(
                            appContext: context,
                            length: 6,
                            controller: pinController,
                            onChanged: (value) {
                              print(value);
                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape
                                  .underline, 
                              fieldHeight: getScaledSizeX(context, 50),
                              fieldWidth: getScaledSizeX(context, 50),
                              activeFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              selectedFillColor: Colors.white,
                              inactiveColor: Colors.black26,
                              selectedColor: Colors.black,
                              activeColor: Colors.black,
                              borderWidth: 1,
                            ),
                            boxShadows: [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 2,
                              ),
                            ],
                            keyboardType: TextInputType.number,
                            autoDismissKeyboard: true,
                            animationType: AnimationType.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 150,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getScaledSizeX(context, 16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
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
                              horizontal: 16, vertical: 6),
                        ),
                      ),
                      onPressed: null,
                      child: Text(
                        'Sign Up',
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
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}