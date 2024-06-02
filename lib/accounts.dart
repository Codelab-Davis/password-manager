import 'package:flutter/material.dart';
import 'package:password_manager/new-account.dart';
import 'package:password_manager/profile-page.dart';
import 'package:password_manager/qrscanner-page.dart';
import 'package:password_manager/totp-page.dart';
import 'package:password_manager/global.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';

class AccountsPage extends StatefulWidget {
  final dynamic user;

  const AccountsPage({super.key, required this.user});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  var firstTap = false;
  var secondTap = false;
  var thirdTap = false;

  var showPassword = true;

  var count = 0;

  void addAccount(
      String appName, String username, String password, String notes) {
    setState(() {
      widget.user[0]['accounts'].add({
        'appName': appName,
        'username': username,
        'password': password,
        'notes': notes
      });
    });
  }

  Widget account(String appName, String username, String password) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Container(
              width: 75,
              height: 75,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  'https://logo.clearbit.com/${appName.replaceAll(' ', '')}.com', // URL of the image
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    // You can return any widget here to display in case of an error
                    return Container();
                  },
                ),
              ),
            ),
          ),
          Text(
            appName,
            style: const TextStyle(
              color: Color(0xFF323232),
              fontSize: 18,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Divider(
              color: Colors.grey, // Color of the divider
              thickness: 1,
            ),
          ),
          Text(
            '@' + username,
            style: const TextStyle(
              color: Color(0xFF323232),
              fontSize: 16,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  password,
                  style: const TextStyle(
                    color: Color(0xFF323232),
                    fontSize: 14,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  changeButtons(button) {
    setState(
      () {
        if (button == 1) {
          firstTap = !firstTap;
          secondTap = false;
          thirdTap = false;
        } else if (button == 2) {
          secondTap = !secondTap;
          firstTap = false;
          thirdTap = false;
        } else if (button == 3) {
          thirdTap = !thirdTap;
          firstTap = false;
          secondTap = false;
        }
      },
    );
  }

  getStyle(buttonTap) {
    return ButtonStyle(
      elevation: MaterialStateProperty.all(0), 
      backgroundColor: MaterialStateProperty.all(
        buttonTap ? const Color(0xFFBCBCE0) : Colors.white,
      ),
      foregroundColor: MaterialStateProperty.all(
        buttonTap ? const Color(0xFF323232) : const Color(0xFF323232),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side: const BorderSide(color: Color(0xFFBCBCE0)),
        ),
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 26, vertical: 6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      //appBar: AppBar(
      // title: const Text("Accounts Page"),
      //automaticallyImplyLeading: false,
      //),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50), // Space from the top
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'PassPal',
                      style: TextStyle(
                        color: Color(0xFF323232),
                        fontSize: 14,
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    const SizedBox(width: 10), // Space between text and icon
                    Image.asset(
                      'assets/icon.png',
                      height: 24, // Adjust the height as needed
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.settings_rounded,
                    color: Color(0xFF283044), // Set the color of the gear icon
                  ),
                  onPressed: () {
                    // Handle the settings icon press
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserProfilePage()),
                    );
                  },
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFBCBCE0),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: SearchBar(
                      elevation: MaterialStateProperty.all(0), 
                leading: const Icon(Icons.search),
                backgroundColor: MaterialStateProperty.all(
                    const Color(0xFFFFFCFC)), // Background color
                hintText: "Search passwords...",
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(
                        color: Color(0xFFBCBCE0), width: 1.0), // Border
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ElevatedButton(
                    style: getStyle(firstTap),
                    onPressed: () => changeButtons(1),
                    child: const Text('Latest'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: getStyle(thirdTap),
                    onPressed: () => changeButtons(3),
                    child: const Text('Earliest'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: getStyle(secondTap),
                    onPressed: () => changeButtons(2),
                    child: const Text('Most Used'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: getStyle(thirdTap),
                    onPressed: () => changeButtons(3),
                    child: const Text('Least Used'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  "Welcome, " + widget.user[0]['firstName'] + '🔒',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 413,
              child: SingleChildScrollView(
                child: MasonryView(
                  listOfItem: List.generate(
                    (widget.user[0]['accounts'].length == 0
                        ? 3
                        : widget.user[0]['accounts'].length + 2),
                    (index) => index,
                  ),
                  numberOfColumn: 2,
                  itemBuilder: (item) {
                    final accounts = widget.user[0]['accounts'];
                    if (item == 0) {
                      if (accounts.length == 0) {
                        return const Center();
                      }
                      final currAccount = accounts[item];
                      final currApp = currAccount['appName'];
                      final currUser = currAccount['username'];
                      final currPass = currAccount['password'];
                      return account(currApp, currUser, currPass);
                    } else if (item == 1) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: SizedBox(
                          height: 60,
                          //
                          child: ElevatedButton(
                            onPressed: () {
                              print(widget.user);
                              print(addAccount);
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewAccount(
                                      user: widget.user,
                                      addAccount: addAccount, secret: '',
                                    ),
                                  ),
                                ).then((result) {
                                  if (result != null) {
                                    setState(() {
                                      widget.user[0]['accounts'] = result;
                                    });
                                  }
                                });
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF374375)),
                              foregroundColor: MaterialStateProperty.all(
                                  Colors.black), // Text color
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        color:
                                            Color(0xffC0C2E9)) // BorderRadius
                                    ),
                              ),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 6)), // Padding
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.white,  
                                  size: 20,
                                ),
                                Text(
                                  "Add Password",
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (item == 2) {
                      return const Center();
                    } else {
                      final currAccount = accounts[item - 2];
                      final currApp = currAccount['appName'];
                      final currUser = currAccount['username'];
                      final currPass = currAccount['password'];
                      return account(currApp, currUser, currPass);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
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
        currentIndex: 3,
        selectedItemColor: const Color.fromARGB(255, 112, 175, 238),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                GenerateTOTPPage(secret: Global.result?.code ?? ''),
          ),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => QRScannerPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context as BuildContext,
          MaterialPageRoute(
            builder: (context) => const UserProfilePage(),
          ),
        );
        // Handle profile navigation
        break;
      case 3:
        break;
    }
  }
}
