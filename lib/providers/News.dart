// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:intl/intl.dart';

class News extends ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items {
    return [..._items];
  }

  Future<void> fetchAndSetData() async {
    // print("fetching data");
    try {
      final firebase = FirebaseFirestore.instance;
      final data = await firebase
          .collection('news')
          .orderBy('date', descending: true)
          .get();
      data.docs.forEach((element) {
        // print(element.data()['date']);
        // print(element.data()['date']);
        var item = element.data();
        _items.add({
          'headline': item['headline'],
          'description': item['description'],
          'date': DateTime.parse(item['date']),
          'imageLink': item['imageLink'],
        });
      });
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  // Future<void> pushData() async {
  //   try {
  //     print("we are pushing data");
  //     final firebaseApp = await Firebase.initializeApp();
  //     print(firebaseApp.name);
  //     final firebase = FirebaseFirestore.instance;
  //     print("we are going to push date");
  //     firebase.collection('news')
  //       ..add({
  //         'headline': "Market crashed",
  //         'description': "Harshad maheta exposed by reporter.",
  //         'date': DateTime.now().toIso8601String(),
  //         'imageLink':
  //             'https://upload.wikimedia.org/wikipedia/commons/7/73/Harshad_Mehta.jpg',
  //       });
  //   } catch (error) {
  //     print(error);
  //   }
  // }
}