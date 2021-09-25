import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatelessWidget {
  static const id = "/news-detail-screen";

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(data['heading']!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, top: 10),
            //   child: Container(
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       DateFormat.yMMMMd().format(DateTime.parse(data['date']!)),
            //       style: TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: ClipRRect(
                child: Image.network(data['imageLink']!),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                DateFormat.yMMMMd().format(DateTime.parse(data['date']!)),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              data["description"]!,
              textAlign: TextAlign.left,
            ),
            //TODO polish this page
          ],
        ),
      ),
    );
  }
}
