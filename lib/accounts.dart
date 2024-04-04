import 'package:flutter/material.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

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
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 220, 220, 220)),
              hintText: "Search passwords...",
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
          ],
        ),
      ),
    );
  }
}
