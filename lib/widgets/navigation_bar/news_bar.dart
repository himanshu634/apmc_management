import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../news_widget/news_item.dart';
import '../../providers/news.dart' show News;

class NewsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsData = Provider.of<News>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: RefreshIndicator(
        onRefresh: () {
          return newsData.fetchAndSetData();
        },
        child: FutureBuilder(
          future: newsData.fetchAndSetData(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if (snapshot.hasError)
              return Center(
                child: Text("Something went wrong"),
              );
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
        ),
      ),
      
    );
  }
}
