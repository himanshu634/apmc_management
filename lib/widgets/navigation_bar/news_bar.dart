import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../news_item.dart';
import '../../providers/news.dart' show News;

class NewsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsData = Provider.of<News>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          return newsData.items.length == 0
              ? Center(
                  child: Text("No news.."),
                )
              : ListView.builder(
                  itemBuilder: (context, index) => NewsItem(
                    heading: newsData.items[index]['headline'],
                    description: newsData.items[index]['description'],
                    date: newsData.items[index]['date'],
                    imageLink: newsData.items[index]['imageLink'],
                  ),
                  itemCount: newsData.items.length,
                );
        },
        future: newsData.fetchAndSetData(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     newsData.fetchAndSetData();
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
