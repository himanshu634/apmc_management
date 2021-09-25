import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/navigation_bar/news_bar.dart';
import '../widgets/navigation_bar/slot_booking_bar.dart';
import '../widgets/navigation_bar/user_bar.dart';
import '../providers/news.dart';
import '../providers/user_data.dart';
import '../providers/slot_booking.dart';

class Home extends StatefulWidget {
  static const id = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var screens = [NewsBar(), SlotBookingBar(), UserBar()];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("APMC"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut(); 
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => News(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => UserData(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => SlotBooking(),
          ),
        ],
        child: screens[_currentIndex],
      ),
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
              icon: const Icon(
                Icons.article,
              ),
              label: "News",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.receipt_long_rounded),
              label: "Booking",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: "User",
            ),
          ],
        ),
      ),
    );
  }
}
