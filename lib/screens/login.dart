import 'package:flutter/material.dart';

import './registration.dart';
import 'otp_screens/otp_screen.dart';
import './home.dart';

class Login extends StatefulWidget {
  static const id = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _numberEditingController = TextEditingController();
  var _isValidate = true;

  bool _validate(val) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (val == null) {
      return false;
    } else if (val.length == 0) {
      return false;
    } else if (!regExp.hasMatch(val)) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildNumberTextField() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            autofocus: true,
            controller: _numberEditingController,
            scrollPadding: const EdgeInsets.only(bottom: 150),
            keyboardType: TextInputType.number,
            onChanged: (val) {
              setState(() {
                _isValidate = _validate(val);
              });
            },
            decoration: InputDecoration(
              errorText: _isValidate ? null : "Please enter valid number.",
              labelText: "Enter Mobile Number",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text("APMC"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: MediaQuery.of(context).size.height * .4),
            _buildNumberTextField(),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(right: 15),
              child: Container(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  //TODO: Here i have to add authentication,currently i am directing to homescreen
                  
                  // onPressed: _isValidate
                  //     ? () => Navigator.of(context).push(
                  //           MaterialPageRoute(
                  //             builder: (context) =>
                  //                 OtpScreen(_numberEditingController.text),
                  //           ),
                  //         )
                  //     : null,
                  onPressed: () => Navigator.of(context).pushReplacementNamed(Home.id),
                  child: const Text("Get OTP"),
                  // ()=> Navigator.of(context).pushReplacementNamed(Home.id)
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed(Registration.id),
              child: const Text("Don't have an account?"),
            ),
          ],
        ),
      ),
    );
  }
}
