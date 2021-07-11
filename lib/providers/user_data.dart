import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData with ChangeNotifier {
  Map<String, dynamic>? userData = {};

  Future<void> fetchAndSetUserData() async {
    try {
      final authInst = FirebaseAuth.instance;
      final inst = FirebaseFirestore.instance;
      inst.collection('users').doc(authInst.currentUser!.uid).get().then((val) {
        userData = val.data();
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> editUserName(String newName) async {
    try {
      userData!['user_name'] = newName;
      final inst = FirebaseFirestore.instance;
      final authInst = FirebaseAuth.instance;
      final docData = inst.collection('users').doc(authInst.currentUser!.uid);
      docData.set(userData!);
    } catch (error) {
      print(error);
    }
  }

  Future<void> villageName(String newVillageName) async {
    try {
      userData!['village_name'] = newVillageName;
      final inst = FirebaseFirestore.instance;
      final authInst = FirebaseAuth.instance;
      final docData = inst.collection("users").doc(authInst.currentUser!.uid);
      docData.set(userData!);
    } catch (error) {
      print(error);
    }
  }
}
