import 'package:flutter/material.dart';
import 'package:password_manager/new-account.dart';
import 'package:password_manager/3rd_party_signin.dart';
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
  int _selectedIndex = 2;
  var firstTap = false;
  var secondTap = false;
  var thirdTap = false;

  var count = 0;

  final List<dynamic> items = [
    Container(
      height: 175,
      color: const Color.fromARGB(255, 220, 220, 220),
      child: const Center(),
    ),
    Container(),
  ];

  void _addAccount() {
    /*
    if (count == 2) {
      items.add(Container());
      print(count);
    } else {
      */
    items.add(
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Container(
          height: 175,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 220, 220, 220),
            borderRadius: BorderRadius.circular(
                10.0), // Add a border radius for rounded corners
          ),
          child: const Center(),
        ),
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
              height: MediaQuery.of(context).size.height - 412,
              child: SingleChildScrollView(
                child: MasonryView(
                  listOfItem: items,
                  numberOfColumn: 2,
                  itemBuilder: (item) {
                    count += 1;
                    if (count == 2) {
                      final addPassword = Padding(
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
                                _addAccount();
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
                      items[1] = addPassword;
                      items.add(const SizedBox(
                        height: 0,
                      ));
                      return addPassword;
                    }
                    return item;
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
        ),
        floatingActionButton: Container(
          width: 345,
          height: 59,
          margin: const EdgeInsets.only(left: 25, right: 25),
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
                    color:
                        _selectedIndex == 0 ? Color(0xFFE4E4F9) : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                    _onItemTapped(0);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.qr_code,
                    size: 35,
                    color:
                        _selectedIndex == 1 ? Color(0xFFE4E4F9) : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                    _onItemTapped(1);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.key_sharp,
                    size: 35,
                    color:
                        _selectedIndex == 2 ? Color(0xFFE4E4F9) : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                    _onItemTapped(2);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    size: 35,
                    color:
                        _selectedIndex == 3 ? Color(0xFFE4E4F9) : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                    _onItemTapped(
                      3,
                    );
                  },
                ),
              ],
            ),
          ),
        ));
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
