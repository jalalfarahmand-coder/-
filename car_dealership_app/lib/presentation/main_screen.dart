import 'package:car_dealership_app/features/calculator/presentation/screens/calculator_screen.dart';
import 'package:car_dealership_app/features/car_deal/presentation/screens/car_deal_screen.dart';
import 'package:car_dealership_app/features/phone_book/presentation/screens/phone_book_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    CarDealScreen(),
    Text('شرکا'), // Placeholder
    PhoneBookScreen(),
    CalculatorScreen(), // Replaced placeholder
    Text('تنظیمات'), // Placeholder
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'خودروها',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'شرکا',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'تلفن',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'محاسبه گر',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'تنظیمات',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // To show all labels
      ),
    );
  }
}
