// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/main.dart';
import 'package:flutter/widgets.dart';
import 'package:password_manager/edit_2fa-page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController NameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Settings',
          style: TextStyle(
            fontSize: getScaledSizeX(context, 24),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: getScaledSizeX(context, 10)),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Color(0xFF374375),
                    fontSize: getScaledSizeX(context, 18),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: getScaledSizeX(context, 167),
              height: getScaledSizeY(context, 167),
              margin: const EdgeInsets.only(top: 50),
              decoration: const ShapeDecoration(
                color: Color(0xFFD9D9D9),
                shape: OvalBorder(),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: getScaledSizeY(context, 7), right: getScaledSizeX(context, 5)),
                  child: Container(
                      width: getScaledSizeX(context, 38),
                      height: getScaledSizeY(context, 38),
                      decoration: const ShapeDecoration(
                          color: Color(0xFFE4E4F9),
                          shape: OvalBorder(),
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                            )
                          ]),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                        iconSize: 20,
                        color: Colors.black,
                      )),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: getScaledSizeY(context, 50), left: getScaledSizeX(context, 25), right: getScaledSizeX(context, 25)),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: getScaledSizeX(context, 20)),
                            child: Text(
                              'Name',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF323232),
                                fontSize: getScaledSizeX(context, 16),
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: getScaledSizeY(context, 10)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: getScaledSizeX(context, 20)),
                          child: Container(
                            decoration: ShapeDecoration(
                              color: Color(0xFFFFFDFC),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0x7F303030)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: getScaledSizeX(context, 5), right: getScaledSizeX(context, 5)),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Paisley Penguin',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: getScaledSizeX(context, 10)),
                                ),
                                controller: NameController,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getScaledSizeY(context, 35)),
                  Container(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: getScaledSizeX(context, 20)),
                            child: Text(
                              'Email Address',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF323232),
                                fontSize: getScaledSizeX(context, 16),
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: getScaledSizeY(context, 10)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: getScaledSizeY(context, 20)),
                          child: Container(
                            decoration: ShapeDecoration(
                              color: Color(0xFFFFFDFC),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0x7F303030)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: getScaledSizeX(context, 5), right:getScaledSizeX(context, 5)),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'paisleypenguin@gmail.com',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: getScaledSizeX(context, 10)),
                                ),
                                controller: EmailController,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getScaledSizeY(context, 35)),
                  Container(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: getScaledSizeX(context, 20)),
                            child: Text(
                              'Phone Number',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF323232),
                                fontSize: getScaledSizeX(context, 16),
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: getScaledSizeX(context, 10)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: getScaledSizeX(context, 20)),
                          child: Container(
                            decoration: ShapeDecoration(
                              color: Color(0xFFFFFDFC),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0x7F303030)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '(123)-456-7890',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: getScaledSizeX(context, 10)),
                                ),
                                controller: PhoneController,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: getScaledSizeY(context, 55)),
                        Container(
                          width: 313,
                          height: 55,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Colors.white,
                            shadows: const [
                              BoxShadow(
                                color: Color.fromARGB(18, 0, 0, 0),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              )
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Edit2FAPage(),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              surfaceTintColor: Color(0xFFE4E4F9),
                              foregroundColor: Color(0xFFE4E4F9),
                              backgroundColor: Color(0xFFE4E4F9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: getScaledSizeX(context, 16), vertical: getScaledSizeY(context, 6)),
                            ),
                            child: Text(
                              'Two-Factor Authentication Method',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: getScaledSizeX(context, 16),
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w600,
                                height: getScaledSizeY(context, 0.04),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
