import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sign Up UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Color defaultColor = Colors.grey.shade400; // Ensuring a shade of grey is used
  final Color selectedColor = Color(0xFFBDBDE0); // Selected color with adjusted alpha value for consistency

  int _selectedButton = -1;

  void _handleButtonPress(int index) {
    setState(() {
      _selectedButton = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 48.0), // Increased vertical padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 64), // Increased space at the top
              const Text(
                'Sign Up to PassPal',
                style: TextStyle(
                  color: Color(0xFF313131),
                  fontSize: 24, // Slightly larger text
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32), // Increased space between elements
              const Text(
                'Enter your login details to create an account',
                style: TextStyle(
                  color: Color(0xFF313131),
                  fontSize: 18, // Slightly larger text
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 48), // Increased space between form fields
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 48), // Increased spacing
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 48), // Increased spacing
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 48), // Increased spacing
              Center(
                child: const Text(
                  'Select your two-factor authentication method',
                  style: TextStyle(
                    color: Color(0xFF323232),
                    fontSize: 18, // Slightly larger text
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 48), // Increased spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/tabler_face-id.svg',
                      color: _selectedButton == 0 ? selectedColor : defaultColor,
                    ),
                    onPressed: () => _handleButtonPress(0),
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/mdi_message-text-clock.svg',
                      color: _selectedButton == 1 ? selectedColor : defaultColor,
                    ),
                    onPressed: () => _handleButtonPress(1),
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/mdi_keypad.svg',
                      color: _selectedButton == 2 ? selectedColor : defaultColor,
                    ),
                    onPressed: () => _handleButtonPress(2),
                  ),
                ],
              ),
              const SizedBox(height: 48), // Increased spacing
              SizedBox(
                width: double.infinity, // Makes the button take the full width of its parent
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedButton >= 0 ? selectedColor : Color.fromRGBO(227, 227, 250, 0.6),
                    padding: const EdgeInsets.symmetric(vertical: 20.0), // Slightly thicker padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Slightly more rounded corners
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20, // Larger text size
                    ),
                  ),
                  onPressed: () {
                    // Implement sign-up logic
                  },
                  child: const Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
