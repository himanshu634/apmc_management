import 'package:flutter/cupertino.dart';

class NewsItem {
  final String headline;
  final String description;
  final String imageLink;

  NewsItem(
      {required this.headline,
      required this.description,
      required this.imageLink});
}

class News extends ChangeNotifier {
  List<NewsItem> _items = [
    NewsItem(
      headline: "Market crashed",
      description: "Harshad maheta exposed by reporter.",
      imageLink:
          "https://en.wikipedia.org/wiki/Harshad_Mehta#/media/File:Harshad_Mehta.jpg",
    ),
  ];

  List<NewsItem> get items {
    return [..._items];
  }
}
