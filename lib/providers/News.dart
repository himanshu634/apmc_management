// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class News extends ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items {
    return [..._items];
  }

  Future<void> fetchAndSetData() async {
    try {
      final firebase = FirebaseFirestore.instance;
      final data = await firebase
          .collection('news')
          .orderBy('date', descending: true)
          .get();
      data.docs.forEach((element) {
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
}
