import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpScreenUpdate extends StatefulWidget {
  static const id = '/otp-screen-update';
  final String mobileNumber;

  OtpScreenUpdate(this.mobileNumber);

  @override
  _OtpScreenUpdateState createState() => _OtpScreenUpdateState();
}

class _OtpScreenUpdateState extends State<OtpScreenUpdate> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String? _verificationCode;

  Future<void> _onSubmit() async {
    try {
      print(_verificationCode);
      await FirebaseAuth.instance.currentUser!
          .updatePhoneNumber(
            PhoneAuthProvider.credential(
              smsCode: _pinPutController.text,
              verificationId: this._verificationCode!,
            ),
          )
          .then((_) => Navigator.of(context).pop(true));
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

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  void _verifyMobileNumber(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${widget.mobileNumber}',
      verificationCompleted: (credential) async {
        try {
          await FirebaseAuth.instance.currentUser!
              .updatePhoneNumber(credential)
              .then((_) async {
            Navigator.of(context).pop(true);
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
        print(error);
        Navigator.of(context).pop();
      },
      codeSent: (verificationId, resendToken) {
        setState(() {
          _verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {
        setState(() {
          _verificationCode = verificationId;
        });
      },
      timeout: Duration(seconds: 60),
    );
  }

  @override
  void initState() {
    super.initState();
    _verifyMobileNumber(context);
  }

  @override
  void dispose() {
    super.dispose();
    _pinPutFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
              child: Text(
                "Please enter your OTP for +91${this.widget.mobileNumber} : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 40, right: 40),
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
      ),
    );
  }
}
