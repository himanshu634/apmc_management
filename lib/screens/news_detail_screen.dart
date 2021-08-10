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
           
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  DateFormat.yMMMMd().format(DateTime.parse(data['date']!)),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                child: ClipRRect(
                  child: Image.network(data['imageLink']!),
                
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(data['description']!),
          ],
        ),
      ),
    );
  }
}
