import 'package:flutter/material.dart';

import '../widgets/navigation_bar/news_bar.dart';
import '../widgets/navigation_bar/vendors_bar.dart';
import '../widgets/navigation_bar/price_list_bar.dart';
import '../widgets/navigation_bar/slot_booking_bar.dart';
import '../widgets/navigation_bar/user_bar.dart';

class Home extends StatefulWidget {
  static const id = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var screens = [
    NewsBar(),
    VendorsBar(),
    SlotBookingBar(),
    PriceListBar(),
    UserBar()
  ];
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("APMC"),
        centerTitle: true,
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
        child: BottomNavigationBar(
          // backgroundColor: Colors.greenAccent[100],
          elevation: 10,
          currentIndex: _currentIndex,
          // selectedIconTheme: ,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.grey[600],
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey[600],
          enableFeedback: true,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.pending),
              label: "News",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.pending),
              label: "Vendors",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.pending),
              label: "Book",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.pending),
              label: "Price",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.pending),
              label: "User",
            ),
          ],
        ),
      ),
    );
  }
}
