import 'package:flutter/material.dart';

class UserBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: Text("user info"),
      ),
    );
  }
}
