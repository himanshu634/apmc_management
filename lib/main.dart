// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/registration.dart';
import './screens/login.dart';
import './constants/const_colors.dart';
import './screens/home.dart';
import 'screens/otp_screens/otp_screen.dart';

void main() {
  //TODO: Focus node in slot Booking
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF4DD637, customColor),
        accentColor: Colors.black,
        backgroundColor: Color(0xFFeffdef),
      ),
      home: Login(),
      routes: {
        Login.id: (ctx) => Login(),
        Registration.id: (ctx) => Registration(),
        Home.id: (ctx) => Home(),
        // OtpScreen.id: (ctx) => OtpScreen(),6
      },
    );
  }
}
