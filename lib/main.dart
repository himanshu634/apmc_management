// import 'dart:html';

import 'package:flutter/material.dart';

import './screens/registration.dart';
import './screens/login.dart';
import './constants/const_colors.dart';
import './screens/home.dart';

void main() {
  //TODO: learn otp authentication
  //TODO: define data-flow
  //TODO: define data structures
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
      ),
      home: Login(),
      routes: {
        Login.id: (ctx) => Login(),
        Registration.id: (ctx) => Registration(),
        Home.id: (ctx) => Home(),
      },
    );
  }
}
