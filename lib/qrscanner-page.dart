import 'package:password_manager/global.dart';
import 'package:password_manager/profile-page.dart';
import 'package:password_manager/totp-page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
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
    );
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
          Navigator.pop(context,secret);
          _resetScanner();
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
