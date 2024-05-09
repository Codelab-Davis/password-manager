import 'package:flutter/material.dart';
import 'package:password_manager/accounts.dart';
import 'global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:clipboard/clipboard.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class NewAccount extends StatefulWidget {
  final dynamic user;
  const NewAccount({super.key, required this.user});

  @override
  State<NewAccount> createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  bool showPassword = false;

  TextEditingController appNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  late File _imageFile;

  bool imagePicked = false;

  Future<void> _getImage() async {
    final imageSource = await showCupertinoModalPopup<ImageSource>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('Take a Picture'),
            onPressed: () {
              Navigator.pop(context, ImageSource.camera);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Choose from Gallery'),
            onPressed: () {
              Navigator.pop(context, ImageSource.gallery);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('Cancel'),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );

    if (imageSource == null) {
      return;
    }

    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: imageSource);

    if (pickedFile == null) {
      return;
    }

    setState(() {
      _imageFile = File(pickedFile.path);
      imagePicked = true;
    });
  }

  void updateUser(
      String appName, String username, String password, String notes) async {
    final id = widget.user[0]['_id'];
    var url = Uri.http('localhost:5000', '/test/updateAccounts/$id');
    final account = jsonEncode({
      'appName': appName,
      'username': username,
      'password': password,
      'notes': notes,
    });
    try {
      await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: account,
      );
      widget.user[0]['accounts'].add(account);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account successfully saved!'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error saving account information! Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EDEC),
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountsPage(user: widget.user)),
                );
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: ShapeDecoration(
                color: const Color(0xFFFFFBFB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              height: MediaQuery.of(context).size.height - 150,
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(40, 50, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Application Name',
                        style: TextStyle(
                          color: Color(0xFF313131),
                          fontSize: 16,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        controller: appNameController,
                        style: const TextStyle(
                          color: Color(0xFF323232),
                          fontSize: 15,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: 'Enter application name',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20)),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(40, 20, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Username',
                        style: TextStyle(
                          color: Color(0xFF313131),
                          fontSize: 16,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: usernameController,
                        style: const TextStyle(
                          color: Color(0xFF323232),
                          fontSize: 15,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: 'Enter username',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20)),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(40, 20, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Password',
                        style: TextStyle(
                          color: Color(0xFF313131),
                          fontSize: 16,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: passwordController,
                        style: const TextStyle(
                          color: Color(0xFF323232),
                          fontSize: 15,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                        obscureText: showPassword,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: 'Enter password',
                            suffixIcon: SizedBox(
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      constraints:
                                          const BoxConstraints(maxWidth: 15),
                                      icon: Icon(showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(
                                          () {
                                            showPassword = !showPassword;
                                          },
                                        );
                                      },
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        FlutterClipboard.copy(
                                                passwordController.text)
                                            .then((_) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Password copied to clipboard'),
                                            ),
                                          );
                                        });
                                      },
                                      icon: const Icon(Icons.copy),
                                    ),
                                  ]),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20)),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(40, 20, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Additional Notes',
                        style: TextStyle(
                          color: Color(0xFF313131),
                          fontSize: 16,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: SizedBox(
                      height: 200,
                      child: TextField(
                        controller: notesController,
                        style: const TextStyle(
                          color: Color(0xFF323232),
                          fontSize: 15,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                        ),
                        keyboardType: TextInputType.multiline,
                        minLines: 6,
                        maxLines: 6,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: 'Insert notes...',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 80,
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFFE4E4F9),
                        ),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6)),
                      ),
                      onPressed: () {
                        updateUser(
                            appNameController.text,
                            usernameController.text,
                            passwordController.text,
                            notesController.text);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AccountsPage(user: widget.user)),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/confirm_changes.svg'),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Confirm Changes',
                            style: TextStyle(
                              color: Color(0xFF313131),
                              fontSize: 16,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w500,
                              height: 0.12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 80,
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFFE4E4F9),
                        ),
                        foregroundColor: MaterialStateProperty.all(
                            Colors.black), // Text color
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6)),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AccountsPage(user: widget.user)),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/delete_entry.svg'),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Delete Entry',
                            style: TextStyle(
                              color: Color(0xFF313131),
                              fontSize: 16,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w500,
                              height: 0.12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 70,
            right: MediaQuery.of(context).size.width - 247.5,
            left: MediaQuery.of(context).size.width - 247.5,
            child: SizedBox(
              width: 100,
              height: 100,
              child: GestureDetector(
                onTap: _getImage,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: ElevatedButton(
                        onPressed: _getImage,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xFFE4E4F9),
                          ),
                          foregroundColor: MaterialStateProperty.all(
                              Colors.black), // Text color
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: const BorderSide(
                                color: Color.fromARGB(200, 0, 0, 0),
                              ),
                            ),
                          ),
                        ),
                        child: Container(),
                      ),
                    ),
                    Positioned.fill(
                      child: imagePicked
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.file(
                                _imageFile,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/add_icon.svg'),
                                const Text(
                                  'Add Icon',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF313131),
                                    fontSize: 12,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
