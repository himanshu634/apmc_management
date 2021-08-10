import 'package:flutter/material.dart';

import '../widgets/registration_form.dart';

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
