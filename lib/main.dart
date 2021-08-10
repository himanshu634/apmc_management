import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/registration.dart';
import './screens/login.dart';
import './constants/const_colors.dart';
import './screens/home.dart';
import './screens/news_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //TODO there is some improvement are pending in image_widget
  //TODO no app check for request
  //TODO polishing of image_widget is pending
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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.data != null)
            return Home();
          else
            return Login();
        },
      ),
      routes: {
        Login.id: (ctx) => Login(),
        Registration.id: (ctx) => Registration(),
        Home.id: (ctx) => Home(),
        NewsDetailScreen.id: (ctx) => NewsDetailScreen(),
      },
    );
  }
}
