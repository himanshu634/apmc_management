import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'commodity_table.dart';
import '../../providers/commodity_detail.dart';

class CommoditySelector extends StatelessWidget {
  final Function onSelect;
  final String? commodityName;

  const CommoditySelector({this.commodityName, required this.onSelect});
  void _selectCommodity(BuildContext context) {
    final commodityDetail =
        Provider.of<CommodityDetail>(context, listen: false);

    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          height: 300,
          child: FutureBuilder(
            future: commodityDetail.fetchAndSetData(),
            builder: (ctx, snapshot) {
              if (snapshot.hasError)
                return Center(child: Text("Something went wrong!!"));

              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );

              return CommodityTable(commodityDetail.items, onSelect);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          padding: const EdgeInsets.all(8),
          // margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                commodityName == null ? "Select Commodity" : commodityName!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down_outlined),
            ],
          ),
        ),
      ),
      onTap: () => _selectCommodity(context),
    );
  }
}
