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

  var count = 0;

  Widget account(String appName, String username, String password) {
    return Container(
       height: 175,
       decoration: BoxDecoration(
         color: const Color.fromARGB(255, 255, 255, 255),
         borderRadius: BorderRadius.circular(
             10.0), // Add a border radius for rounded corners
       ),
       child: Column(
         children: [
           ClipRRect(
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
           const Divider(
             color: Colors.black, // Color of the divider
             thickness: 2,
           ),
           Text(username),
           Text(password)
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
      backgroundColor: MaterialStateProperty.all(
          buttonTap ? const Color(0xff374375) : Colors.white),
      foregroundColor: MaterialStateProperty.all(
          buttonTap ? Colors.white : Colors.black), // Text color
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side: const BorderSide(color: Colors.black) // BorderRadius
          )),
      padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 6)), // Padding
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F9),
      appBar: AppBar(
        title: const Text("Accounts Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(
              leading: const Icon(Icons.search),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xffF7EDEC)),
              hintText: "Search passwords...",
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
                    child: const Text('Recently Added'),
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
                  listOfItem: List.generate(widget.user[0]['accounts'].length + 1, (index) => index),
                  numberOfColumn: 2,
                  itemBuilder: (item) {
                    final accounts =  widget.user[0]['accounts'];
                    if(item == 0) {
                      final currAccount = accounts[item];
                      final currApp = currAccount['appName'];
                      final currUser =  currAccount['username'];
                      final currPass = currAccount['password'];
                      return account(currApp, currUser, currPass);
                    }
                    else if (item == 1) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewAccount(user: widget.user)),
                                );
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xffBCBCE0)),
                              foregroundColor: MaterialStateProperty.all(
                                  Colors.black), // Text color
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        color: Color(0xffC0C2E9)) // BorderRadius
                                    ),
                              ),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 6)), // Padding
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.add),
                                Text(
                                  "Add Password",
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    else {
                      final currAccount = accounts[item - 1];
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
