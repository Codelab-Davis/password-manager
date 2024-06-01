import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:password_manager/profile-page.dart';
import 'package:password_manager/qrscanner-page.dart';
import 'package:password_manager/totp-page.dart';
import 'package:password_manager/global.dart';

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

  changeButtons(button) {
    setState(() {
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
    });
  }

  getStyle(buttonTap) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
          buttonTap ? const Color.fromARGB(255, 220, 220, 220) : Colors.white),
      foregroundColor:
          MaterialStateProperty.all(const Color(0xFF404447)), // Text color
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
        side: const BorderSide(color: Colors.black), // BorderRadius
      )),
      padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 6)), // Padding
    );
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 2;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F9),
      appBar: AppBar(
        title: const Text(
        'Accounts',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(
                leading: const Icon(Icons.search),
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 220, 220, 220)),
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
                child: const FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Welcome, Suyash 🔒",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: MediaQuery.of(context).size.height - 350,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 1) {
                      return ButtonTheme(
                        height: 10,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 220, 220, 220)),
                            foregroundColor: MaterialStateProperty.all(
                                const Color(0xFF404447)), // Text color
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                                // BorderRadius
                              ),
                            ),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6)),
                          ),
                          child: const Text("Add Password"),
                        ),
                      );
                    }
                    return Container(
                      height: 300,
                      color: const Color.fromARGB(255, 220, 220, 220),
                      child: const Center(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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
            builder: (context) =>
                GenerateTOTPPage(secret: Global.qr_result?.code ?? ''),
          ),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => QRScannerPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context as BuildContext,
          MaterialPageRoute(
            builder: (context) => const UserProfilePage(),
          ),
        );
        break;
      case 2:
        break;
    }
  }
}
