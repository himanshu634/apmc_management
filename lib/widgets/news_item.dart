import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsItem extends StatelessWidget {
  final String heading;
  final String description;
  final DateTime date;
  final String imageLink;

  const NewsItem({
    required this.heading,
    required this.description,
    required this.date,
    required this.imageLink,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 10,
      ),
      child: Card(
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            title: Text(
              heading,
              style: TextStyle(
                color: Colors.green[500],
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[900],
                  ),
                ),
                Text(
                  DateFormat.yMMMd().format(date),
                ),
              ],
            ),
            leading: Container(
              width: 50,
              height: 50,
              child: Image.network(
                imageLink,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
