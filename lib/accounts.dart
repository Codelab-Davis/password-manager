import 'package:flutter/material.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

final style = ElevatedButton.styleFrom(
  backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Background color
  foregroundColor: const Color(0xFF404447), // Text color// Elevation
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(35),
    side: const BorderSide(color: Colors.black) // BorderRadius
  ),
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), // Padding
  shadowColor: const Color(0x3F000000), // Shadow color
);

class _AccountsPageState extends State<AccountsPage> {
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
              backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ElevatedButton(
                    style: style,
                    onPressed: () {},
                    child: const Text('Recently Added'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: style,
                    onPressed: () {},
                    child: const Text('Most Used'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: style,
                    onPressed: () {},
                    child: const Text('Least Used'),
                  ),
                ],
              ),
            ),
            const Text("Welcome, Suyash 🔒"),
          ],
        ),
      ),
    );
  }
}
