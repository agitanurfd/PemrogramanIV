import 'package:flutter/material.dart';
// import 'package:assesmen_1214029_agita/input.dart';
import 'package:assesmen_1214029_agita/home.dart';
// import 'package:assesmen_1214029_agita/input_validation.dart';
import 'package:assesmen_1214029_agita/input_form.dart';

class DynamicBottomNavBar extends StatefulWidget {
  const DynamicBottomNavBar({super.key});

  @override
  State<DynamicBottomNavBar> createState() => _DynamicBottomNavBarState();
}

class _DynamicBottomNavBarState extends State<DynamicBottomNavBar> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = const [
    MyHome(),
    // MyInputValidation(),
    MyForm(),
  ];

// void tombol
  void onTabTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Change to home icon
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail), // Change to contact list icon
            label: 'Contact List',
          ),
        ],
        backgroundColor: Colors.black,
        selectedItemColor: const Color.fromARGB(255, 129, 177, 179),
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
