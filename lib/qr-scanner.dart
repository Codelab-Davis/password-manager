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
            child: Stack(
                children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 200,
                    height: 200,
                    child: Stack(
                      children: <Widget>[
                        // Top left corner
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 5, // Reduced width of the vertical segment
                            height: 20, // Reduced height of the vertical segment
                            decoration: BoxDecoration(
                              color: Color(0xFF89515A),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(125),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 20, // Reduced width of the horizontal segment
                            height: 5, // Reduced height of the horizontal segment
                            decoration: BoxDecoration(
                              color: Color(0xFF89515A),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(125),
                              ),
                            ),
                          ),
                        ),
                        // Top right corner
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 5,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Color(0xFF89515A),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(125),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 20,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Color(0xFF89515A),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(125),
                              ),
                            ),
                          ),
                        ),
                        // Bottom left corner
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Container(
                            width: 5,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Color(0xFF89515A),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(125),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Container(
                            width: 20,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Color(0xFF89515A),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(125),
                              ),
                            ),
                          ),
                        ),
                        // Bottom right corner
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 5,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Color(0xFF89515A),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(125),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 20,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Color(0xFF89515A),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(125),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
            icon: Icon(Icons.settings),
            label: 'Settings',
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
          MaterialPageRoute(builder: (context) => UserProfilePage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => const AccountsPage()),
        );
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
