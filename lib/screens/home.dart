import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const id = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("APMC"),
        centerTitle: true,
      ),
      body: Center(
        child: const Text("Here home page will be shown"),
      ),
    );
  }
}
