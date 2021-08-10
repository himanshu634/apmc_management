import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommodityDetail with ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items {
    return [..._items];
  }

  Future<void> fetchAndSetData() async {
    try {
      final instance = FirebaseFirestore.instance;
      final data = await instance.collection('commodities_table').get();
      data.docs.forEach((element) {
        var e = element.data();
        _items.add({
          'name': e['commodity_name'],
          'start_date': DateTime.parse(e['start_date']),
          'end_date': DateTime.parse(e['end_date']),
        });
      });
    } catch (error) {
      throw error;
    }
  }
}
