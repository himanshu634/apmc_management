import 'package:flutter/material.dart';

// import '../screens/home.dart';
import '../widgets/registratin_form.dart';

// import '../constants/const_colors.dart';

class Registration extends StatelessWidget {
  static const id = '/registration';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
      ),
      body: Center(
        child: RegistrationForm(),
      ),
     
    );
  }
}
