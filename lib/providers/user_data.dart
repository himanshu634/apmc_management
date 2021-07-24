import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../screens/otp_screens/otp_screen_update.dart';
import '../models/primary_exception.dart';

class UserData with ChangeNotifier {
  Map<String, dynamic>? userData = {};

  Future<bool> fetchAndSetUserData() async {
    try {
      final authInst = FirebaseAuth.instance;
      final inst = FirebaseFirestore.instance;
      await inst
          .collection('users')
          .doc(authInst.currentUser!.uid)
          .get()
          .then((val) {
        userData = val.data();
      });
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> editUserName(String newName,
      {required BuildContext context}) async {
    try {
      userData!['user_name'] = newName;
      final inst = FirebaseFirestore.instance;
      final authInst = FirebaseAuth.instance;
      final docData = inst.collection('users').doc(authInst.currentUser!.uid);
      await docData.set(userData!);
      notifyListeners();
      return true;
    } catch (error) {
      throw PrimaryException("Sorry, we can't update you name.");
    }
  }

  Future<bool> editVillageName(String newVillageName,
      {required BuildContext context}) async {
    try {
      userData!['village_name'] = newVillageName;
      final inst = FirebaseFirestore.instance;
      final authInst = FirebaseAuth.instance;
      final docData = inst.collection("users").doc(authInst.currentUser!.uid);
      await docData.set(userData!);
      notifyListeners();
      return true;
    } catch (error) {
      throw PrimaryException("Sorry, we can't update your village name.");
    }
  }

  Future<bool> editMobileNumber(String newNumber,
      {required BuildContext context}) async {
    try {
      Navigator.of(context).pop();
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) {
            return OtpScreenUpdate(newNumber);
          },
        ),
      ).then((status) async {
        if (status) {
          userData!['mobile_number'] = newNumber;
          final inst = FirebaseFirestore.instance;
          final authInst = FirebaseAuth.instance;
          await inst
              .collection('users')
              .doc(authInst.currentUser!.uid)
              .set(userData!);
          notifyListeners();
          return true;
        } else {
          print("we are here");
          throw PrimaryException("Sorry, we can't update your mobile number.");
        }
      });
    } catch (error) {
      throw PrimaryException("Sorry, we can't update your mobile number.");
    }
    return false;
  }

  Future<void> addPhoto(File image) async {
    try {
      final authRef = FirebaseAuth.instance;
      final firestoreRef = FirebaseFirestore.instance;
      final ref = FirebaseStorage.instance
          .ref()
          .child('users_image')
          .child(authRef.currentUser!.uid + ".jpg");
      await ref.putFile(image);
      final imageUrl = await ref.getDownloadURL();
      await firestoreRef.collection('users').doc(authRef.currentUser!.uid).set({
        "profile_pic_link": imageUrl,
        "mobile_number": userData!['mobile_number'],
        "user_name": userData!['user_name'],
        "village_name": userData!['village_name'],
      });
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
