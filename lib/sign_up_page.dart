import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: AuthenticationScreen(),
        ),
      ),
    );
  }
}

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  String signUpButtonText = 'Sign Up'; // Initial text for the sign-up button
  Color faceIdColor = Color(0xFFFFFDFC);
  Color smsPasscodeColor = Color(0xFFFFFDFC);
  Color sixDigitColor = Color(0xFFFFFDFC);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: 852,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Color(0xFFFFFBFB)),
      child: Stack(
        children: [
          titleText('Sign up to PassPal', 0.08, 88, 0.7, 30, 25, FontWeight.w700, 0.05, screenWidth),
          titleText('Select your two-factor authentication method', 0.08, 124, 0.84, null, 16, FontWeight.w400, 0.07, screenWidth),
          authenticationOption('Face ID', 'tabler_face-id.svg', 0.34, 190, 321, screenWidth, faceIdColor, () => setColor('faceId')),
          authenticationOption('SMS Passcode', 'mdi_message-text-clock.svg', 0.34, 368, 488, screenWidth, smsPasscodeColor, () => setColor('sms')),
          authenticationOption('6-digit Passcode', 'mdi_keypad.svg', 0.34, 546, 654, screenWidth, sixDigitColor, () => setColor('sixDigit')),
          signUpButton(screenWidth),
        ],
      ),
    );
  }

  Widget titleText(String text, double leftPercentage, double top, double widthPercentage, double? height, double fontSize, FontWeight fontWeight, double heightFactor, double screenWidth) {
    return Positioned(
      left: screenWidth * leftPercentage,
      top: top,
      child: Container(
        width: screenWidth * widthPercentage,
        height: height,
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xFF313131),
            fontSize: fontSize,
            fontFamily: 'Outfit',
            fontWeight: fontWeight,
            height: heightFactor,
          ),
        ),
      ),
    );
  }

  void setColor(String button) {
    setState(() {
      // Reset all button colors to original
      faceIdColor = Color(0xFFFFFDFC);
      smsPasscodeColor = Color(0xFFFFFDFC);
      sixDigitColor = Color(0xFFFFFDFC);

      // Set the color of the currently pressed button
      if (button == 'faceId') {
        faceIdColor = Color(0xFFBCBCE0);
      } else if (button == 'sms') {
        smsPasscodeColor = Color(0xFFBCBCE0);
      } else if (button == 'sixDigit') {
        sixDigitColor = Color(0xFFBCBCE0);
      }

      // Change the sign-up button text to "Continue"
      signUpButtonText = 'Continue';
    });
  }

Widget authenticationOption(String text, String svgPath, double leftPercentage, double topCircle, double topText, double screenWidth, Color bgColor, VoidCallback onTap) {
    double circleSize = screenWidth * 0.30;  // Circle size relative to the screen width
    double paddingSize = 20;  // Padding to reduce the SVG size visually
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Positioned(
            left: (screenWidth - circleSize) / 2,  // Centering the circle horizontally
            top: topCircle,
            child: Container(
              width: circleSize,
              height: circleSize,
              padding: EdgeInsets.all(paddingSize), // Padding to make SVG appear smaller
              decoration: ShapeDecoration(
                color: bgColor,
                shape: CircleBorder(),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: SvgPicture.asset('assets/$svgPath', fit: BoxFit.contain),
            ),
          ),
          Positioned(
            left: (screenWidth - circleSize) / 2,
            top: topText,
            child: SizedBox(
              width: circleSize,  // Set to the same width as the circle to ensure center alignment
              height: 15,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF323232),
                  fontSize: 16,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget signUpButton(double screenWidth) {
    return Positioned(
      left: screenWidth * 0.08,
      top: 719,
      child: Container(
        width: screenWidth * 0.82,
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: ShapeDecoration(
          color: Color(0xFFE4E4F9),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: [
            BoxShadow(
              color: Color(0xFFD9D9D9),
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            signUpButtonText, // Use the variable for the button text
            style: TextStyle(
              color: Color(0xFF323232),
              fontSize: 16,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}