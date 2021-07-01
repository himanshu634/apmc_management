import 'package:flutter/material.dart';

import '../slot_booking_widget.dart';

class SlotBookingBar extends StatelessWidget {
  const SlotBookingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlotBookingWidget(),
    );
  }
}
