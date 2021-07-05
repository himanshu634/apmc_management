import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OtpScreen extends StatefulWidget {
  static const id = "/otp-screen";
  final String mobileNumber;
  final String userName;
  final String villageName;
  OtpScreen({
    required this.mobileNumber,
    required this.userName,
    required this.villageName,
  });

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String? _verificationCode;

  @override
  Widget build(BuildContext context) {
    print('we are in otp screen');
    print(widget.mobileNumber);
    print(widget.userName);
    print(widget.villageName);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
              child: Text(
                "Please enter your OTP for +91${widget.mobileNumber} : ",
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
                  onSubmit: (String pin) async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: this._verificationCode!,
                              smsCode: pin))
                          .then((value) async {
                        if (value.user != null) {
                          print("WE are in ");
                        }
                      });
                    } catch (error) {
                      print(error);
                    }
                  },
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
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _verifyMobileNumber();
  }

  void _verifyMobileNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${widget.mobileNumber}',
      verificationCompleted: (credential) async {
        try {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((val) async {
            //TODO: remove
            print("wE are in completed");
            if (val.user != null) {
              final inst = FirebaseFirestore.instance;
              await inst.collection('users').add({
                'user_name': this.widget.userName,
                'village_name': this.widget.villageName,
                'mobile_number': this.widget.mobileNumber,
              });
            }
          });
        } catch (erorr) {
          print(erorr);
        }
      },
      verificationFailed: (error) {
        print(error);
      },
      codeSent: (verificationId, resendToken) {
        //TODO remove
        print("in codesetn");
        setState(() {
          _verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {
        //TODO remove
        print("auto retreival");
        setState(() {
          _verificationCode = verificationId;
        });
      },
      timeout: Duration(seconds: 60),
    );
  }

  // void _showSnackBar(String pin, BuildContext context) {
  //   final snackBar = SnackBar(
  //     duration: const Duration(seconds: 3),
  //     content: Container(
  //       height: 80.0,
  //       child: Center(
  //         child: Text(
  //           'Pin Submitted. Value: $pin',
  //           style: const TextStyle(fontSize: 25.0),
  //         ),
  //       ),
  //     ),
  //     backgroundColor: Colors.deepPurpleAccent,
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(15.0),
    );
  }
}
