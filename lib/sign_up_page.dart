import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          leading: const Icon(Icons.arrow_back), 
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Please select your preferred 2-factor authentication method',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 24), 
              AuthenticationMethodButton(
                text: 'Face ID',
                icon: Icons.face, 
                onPressed: () {
                 
                },
              ),
              const SizedBox(height: 16),
              AuthenticationMethodButton(
                text: 'SMS Passcode',
                icon: Icons.sms, 
                onPressed: () {
                 
                },
              ),
              const SizedBox(height: 16),
              AuthenticationMethodButton(
                text: '6-digit Passcode',
                icon: Icons.lock, 
                onPressed: () {
                 
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthenticationMethodButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const AuthenticationMethodButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 40), 
      label: Text(text),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200], 
        foregroundColor: Colors.black, 
        shape: const CircleBorder(), 
        padding: const EdgeInsets.all(24), 
        textStyle: const TextStyle(
          color: Colors.black, 
        ),
        elevation: 0, 
      ),
    );
  }
}
