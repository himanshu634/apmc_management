import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SlotBooking with ChangeNotifier {
  Future<void> uploadDetails({
    required String name,
    required String commodityName,
    required int quantity,
    required DateTime date,
    required String aadharNumber,
    required String mobileNumber,
  }) async {
    try {
      final authInst = FirebaseAuth.instance;
      final dbInst = FirebaseFirestore.instance;
      await dbInst
          .collection('booking_data')
          .doc(commodityName)
          .collection(mobileNumber)
          .add({
        "name": name,
        "commodity_name": commodityName,
        "quantity": quantity.toString(),
        "date": date.toIso8601String(),
        "aadhar_number": aadharNumber,
        "mobile_number": mobileNumber,
        'user_id': authInst.currentUser!.uid,
      });
    } catch (error) {
      //TODO remove this
      print(error);
    }
  }
}
