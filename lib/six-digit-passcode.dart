import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SixDigitPasscodePage(),
  ));
}

class SixDigitPasscodePage extends StatefulWidget {
  const SixDigitPasscodePage({Key? key}) : super(key: key);

  @override
  _SixDigitPasscodePageState createState() => _SixDigitPasscodePageState();
}

class _SixDigitPasscodePageState extends State<SixDigitPasscodePage> {
  final TextEditingController controller = TextEditingController();

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
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
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
                  
          ],
        ),
      ),
          ]
        ),
      ),
    );
  }
}
