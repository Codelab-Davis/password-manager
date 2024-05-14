import 'package:password_manager/profile-page.dart';
import 'package:password_manager/totp-page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/global.dart';
import 'package:password_manager/accounts.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isScanning = true;

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 1;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'QR Scanner',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.transparent,
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
                    width: 250,
                    height: 300,
                    child: Stack(
                      children: <Widget>[
                        // Top left corner
                        Positioned(
                          left: 0,
                          top: 4,
                          child: Container(
                            width: 5,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 0, 0, 0),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 20,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 0, 0, 0),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(125),
                              ),
                            ),
                          ),
                        ),
                        // Top right corner
                        Positioned(
                          right: 0,
                          top: 4,
                          child: Container(
                            width: 5,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 0, 0, 0),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(0),
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
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 0, 0, 0),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(125),
                              ),
                            ),
                          ),
                        ),
                        // Bottom left corner
                        Positioned(
                          left: 0,
                          bottom: 4,
                          child: Container(
                            width: 5,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 0, 0, 0),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
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
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 0, 0, 0),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(125),
                              ),
                            ),
                          ),
                        ),
                        // Bottom right corner
                        Positioned(
                          right: 0,
                          bottom: 4,
                          child: Container(
                            width: 5,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 0, 0, 0),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(0),
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
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 0, 0, 0),
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
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text('Scan a code'),
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        width: 365,
        height: 59,
        margin: const EdgeInsets.only(left: 15, right: 18),
        decoration: BoxDecoration(
          color: Color(0xFF374375),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: 35,
                  color: _selectedIndex == 0 ? Color(0xFFE4E4F9) : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                  _onItemTapped(0, context);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.qr_code,
                  size: 35,
                  color: _selectedIndex == 1 ? Color(0xFFE4E4F9) : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                  _onItemTapped(1, context);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.key_sharp,
                  size: 35,
                  color: _selectedIndex == 2 ? Color(0xFFE4E4F9) : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                  _onItemTapped(2, context);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  size: 35,
                  color: _selectedIndex == 3 ? Color(0xFFE4E4F9) : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                  _onItemTapped(3, context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  GenerateTOTPPage(secret: result?.code ?? '')),
        );
        break;
      case 1:
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const AccountsPage(
                    user: null,
                  )),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AccountsPage(user: Global.user)),
        );
        break;
    }
  }

  Future<void> _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (isScanning) {
        setState(() {
          result = scanData;
          isScanning = false;
        });
        Uri uri = Uri.parse(result!.code!);
        String? secret = uri.queryParameters['secret'];

        if (secret != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => GenerateTOTPPage(secret: secret)),
          ).then((value) => _resetScanner());
        } else {
          _resetScanner();
        }
      }
    });
  }

  void _resetScanner() {
    if (controller != null) {
      controller!.resumeCamera();
      isScanning = true;
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
