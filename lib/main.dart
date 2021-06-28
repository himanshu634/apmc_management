// import 'dart:html';

import 'package:flutter/material.dart';

import './screens/registration.dart';
import './screens/login.dart';
import './constants/const_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF4DD637, customColor),
        accentColor: Colors.black,
        // primaryColor: Color(0xFF4DD637)
        // buttonColor:
      ),
      home: Registration(),
      routes: {
        Login.id: (ctx) => Login(),
      },
    );
  }
}
