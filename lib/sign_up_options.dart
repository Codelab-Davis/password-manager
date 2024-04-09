import 'package:flutter/material.dart';
import 'home_page.dart';

class SignUpOptions extends StatefulWidget {
  const SignUpOptions({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SignUpOptions createState() => _SignUpOptions();
}

class _SignUpOptions extends State<SignUpOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0), // Adjust padding as needed
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button click action here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Use Colors.white for perfectly white background
                    foregroundColor: Color(0xFFF34535), // Text color
                    elevation: 0, // Set elevation to 0 to remove shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // BorderRadius
                    ),
                    side: BorderSide(
                        color: Color(0xFFF34535),
                        width: 2), // Border color and width
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16), // Padding
                    minimumSize: Size(280, 45), // Minimum button size
                  ),
                  child: const Row(
                    children: [
                      Image(
                        image: AssetImage('assets/google.png'),
                        height: 24, // Adjust image height as needed
                      ),
                      SizedBox(width: 8), // Add some space between image and text
                      Text('Google'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0), // Adjust padding as needed
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button click action here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Use Colors.white for perfectly white background
                    foregroundColor: Color.fromARGB(255, 0, 0, 0), // Text color
                    elevation: 0, // Set elevation to 0 to remove shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // BorderRadius
                    ),
                    side:  BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0),
                        width: 2), // Border color and width
                    padding:  EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16), // Padding
                    minimumSize: Size(280, 45), // Minimum button size
                  ),
                  child: const Row(
                    children: [
                      Image(
                        image: AssetImage('assets/apple.png'),
                        height: 24, // Adjust image height as needed
                      ),
                      SizedBox(width: 8), // Add some space between image and text
                      Text('Apple'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0), // Adjust padding as needed
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button click action here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Use Colors.white for perfectly white background
                    foregroundColor: Color(0xFF1877F2), // Text color
                    elevation: 0, // Set elevation to 0 to remove shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // BorderRadius
                    ),
                    side:  BorderSide(
                        color: Color(0xFF1877F2),
                        width: 2), // Border color and width
                    padding:  EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16), // Padding
                    minimumSize: Size(280, 45), // Minimum button size
                  ),
                  child: const Row(
                    children: [
                      Image(
                        image: AssetImage('assets/facebook.png'),
                        height: 24, // Adjust image height as needed
                      ),
                      SizedBox(width: 8), // Add some space between image and text
                      Text('Facebook'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 200.0), // Space with a height of 100.0
              const Divider(
                height: 20,
                thickness: 2,
                color: Color(0xFF323232),
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 280,
                height: 45,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MyHomePage(title: "Create Log In")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD9D9D9), // Background color
                      foregroundColor: Color(0xFF323232), // Text color
                      elevation: 6, // Elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // BorderRadius
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6), // Padding
                      shadowColor: Color(0x3F000000), // Shadow color
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Create Log In',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
