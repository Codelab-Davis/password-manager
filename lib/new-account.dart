import 'package:flutter/material.dart';

class NewAccount extends StatefulWidget {
  const NewAccount({super.key});

  @override
  State<NewAccount> createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EDEC),
      appBar: AppBar(
        backgroundColor: const Color(0xffF7EDEC),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Align(
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
              const Padding(
                padding: EdgeInsets.only(
                    left: 40.0,
                    right:
                        40.0), // Adds padding of 20 pixels to the left and right
                child: SizedBox(
                  height: 45,
                  child: TextField(
                    style: TextStyle(
                      color: Color(0xFF323232),
                      fontSize: 15,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                    decoration: InputDecoration(
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
              const Padding(
                padding: EdgeInsets.only(
                    left: 40.0,
                    right:
                        40.0), // Adds padding of 20 pixels to the left and right
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    style: TextStyle(
                      color: Color(0xFF323232),
                      fontSize: 15,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                    decoration: InputDecoration(
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
                padding: const EdgeInsets.only(
                    left: 40.0,
                    right:
                        40.0), // Adds padding of 20 pixels to the left and right
                child: SizedBox(
                  height: 50,
                  child: TextField(
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
                        suffixIcon: IconButton(
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
              const Padding(
                padding: EdgeInsets.only(
                    left: 40.0,
                    right:
                        40.0), // Adds padding of 20 pixels to the left and right
                child: SizedBox(
                  height: 200,
                  child: TextField(
                    style: TextStyle(
                      color: Color(0xFF323232),
                      fontSize: 15,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 6,
                    maxLines: 6,
                    decoration: InputDecoration(
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
                        MaterialStateProperty.all(Colors.black), // Text color
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                              color:
                                  Color.fromARGB(200, 0, 0, 0)) // BorderRadius
                          ),
                    ),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6)), // Padding
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/CheckboxIcon.png'),
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
                    foregroundColor:
                        MaterialStateProperty.all(Colors.black), // Text color
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                              color:
                                  Color.fromARGB(200, 0, 0, 0)) // BorderRadius
                          ),
                    ),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6)), // Padding
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/Delete.png'),
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
    );
  }
}
