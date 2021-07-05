import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class CommodityTable extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Function onSelect;

  const CommodityTable(this.items, this.onSelect);

  static const TextStyle kbarStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    List<DataRow> _buildDataRow() {
      return items
          .map(
            (item) => DataRow(
              cells: [
                DataCell(
                  InkWell(
                    child: Text(item['name']),
                    onTap: () => onSelect(item['name']),
                  ),
                ),
                DataCell(
                  InkWell(
                    child: Text(
                        DateFormat('dd/MM/yyyy').format(item['start_date'])),
                    onTap: () => onSelect(item['name']),
                  ),
                ),
                DataCell(
                  InkWell(
                    child:
                        Text(DateFormat('dd/MM/yyyy').format(item['end_date'])),
                    onTap: () => onSelect(item['name']),
                  ),
                ),
              ],
            ),
          )
          .toList();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text("Commodity Name", style: kbarStyle),
            ),
            DataColumn(
              label: const Text("Start Date", style: kbarStyle),
            ),
            DataColumn(
              label: const Text("End Date", style: kbarStyle),
            ),
          ],
          rows: _buildDataRow(),
        ),
      ),
    );
  }
}
