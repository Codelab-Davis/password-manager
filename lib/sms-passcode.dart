import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

void main() {
  runApp(MaterialApp(
    home: SMSPasscodePage(),
  ));
}

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

  void savePhoneNumber() {
    if (number.phoneNumber != null && number.phoneNumber!.length == 10) {
      setState(() {
        isValid = true;
        validPhoneNumber = number;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Number'),
            content: Text('Please enter a valid 10-digit phone number.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                color: Colors.green,
                                width: 2.0,
                              ),
                            ),
                          ),
                          onInputChanged: (PhoneNumber number) {
                            setState(() {
                              this.number = number;
                            });
                          },
                          textFieldController: controller,
                          initialValue: PhoneNumber(
                            isoCode: 'US',// Example valid US phone number
                          ),
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: savePhoneNumber,
                    child: Text('Save Number'),
                  ),
                  if (isValid)
                    Text(
                      'Valid Number: ${validPhoneNumber!.phoneNumber}',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
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
