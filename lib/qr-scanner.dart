import 'package:password_manager/profile-page.dart';
import 'package:password_manager/totp_generator.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:otp/otp.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/accounts.dart';



class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'QR Scanned: ${result!.code}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text('Scan a code'),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), // Corrected icon for the fourth option
            label: 'Settings', // Label for the new fourth button
          ),
        ],
        currentIndex: 1,
        selectedItemColor: Color.fromARGB(255, 112, 175, 238),
        unselectedItemColor: Colors.grey, 
        onTap: _onItemTapped,
      ),
    );
  }

void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => GenerateTOTPPage()),
        );
        break;
      case 1:
        break;
      case 2:
        Navigator.pushReplacement(
          context as BuildContext,
            MaterialPageRoute(builder: (context) => UserProfilePage(),        
              ),
            );
        // Handle profile navigation
        break;
        case 3:
        Navigator.pushReplacement(
          context as BuildContext,
            MaterialPageRoute(builder: (context) => const AccountsPage(),        
              ),
            );
        // Handle profile navigation
        break;
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}




