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
  final Color defaultColor = Colors.grey;
  final Color selectedColor = const Color(0xFFBCBCEO); 

  int _selectedButton = -1;

  void _handleButtonPress(int index) {
    setState(() {
      _selectedButton = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up to PassPal'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'Enter your login details to create an account',
                style: TextStyle(
                  color: Color(0xFF313131),
                  fontSize: 16,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Select your two-factor authentication method',
                style: TextStyle(
                  color: Color(0xFF323232),
                  fontSize: 16,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/tabler_face-id.svg', // Changed to a likely correct asset path
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
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class O {
}
