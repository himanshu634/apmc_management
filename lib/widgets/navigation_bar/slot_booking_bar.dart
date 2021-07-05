import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../slot_booking/slot_booking_widget.dart';
import '../../providers/commodity_detail.dart';

class SlotBookingBar extends StatelessWidget {
  const SlotBookingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider(
        create: (ctx) => CommodityDetail(),
        child: SlotBookingWidget(),
      ),
    );
  }
}
