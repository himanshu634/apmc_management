import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../home.dart';

class OtpScreenLogin extends StatefulWidget {
  static const id = "/otp-screen-login";
  final String mobileNumber;

  OtpScreenLogin({
    required this.mobileNumber,
  });

  @override
  _OtpScreenLoginState createState() => _OtpScreenLoginState();
}

class _OtpScreenLoginState extends State<OtpScreenLogin> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String? _verificationCode;

  Future<void> _onSubmit() async {
    try {
      final authInstance = await FirebaseAuth.instance.signInWithCredential(
          PhoneAuthProvider.credential(
              smsCode: _pinPutController.text,
              verificationId: this._verificationCode!));
      if (authInstance.user != null)
        Navigator.of(context).pushReplacementNamed(Home.id);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfAlreadyUser().then((value) {
      if (value == true) {
        _verifyMobileNumber(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pinPutFocusNode.dispose();
  }

  void _verifyMobileNumber(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${widget.mobileNumber}',
      verificationCompleted: (credential) async {
        try {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((val) async {
            if (val.user != null) {
              Navigator.of(context).pushReplacementNamed(Home.id);
            }
          });
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      verificationFailed: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            duration: Duration(seconds: 3),
          ),
        );
      },
      codeSent: (verificationId, resendToken) {
        setState(() {
          _verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {
        //TODO Edit this
      },
      timeout: Duration(seconds: 60),
    );
  }

  Future<bool> _checkIfAlreadyUser() async {
    try {
      final inst = FirebaseFirestore.instance;
      final data = await inst.collection("users").get();
      return data.docs.any((element) =>
          element.data()['mobile_number'] == this.widget.mobileNumber);
    } catch (error) {
      //TODO change it to snackbar
      print(error);
      return false;
    }
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: FutureBuilder(
        future: _checkIfAlreadyUser(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          if (snapshot.data == true) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Text(
                      "Please enter your OTP for +91${this.widget.mobileNumber} : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 40, right: 40),
                    child: SizedBox(
                      height: 50,
                      child: PinPut(
                        fieldsCount: 6,
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                        submittedFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        selectedFieldDecoration: _pinPutDecoration,
                        followingFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        autofocus: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      child: const Text("Submit"),
                      onPressed: () {
                        _onSubmit();
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: const Text("Your mobile number does not exists"),
            );
          }
        },
      ),
    );
  }
}
