import 'package:flutter/material.dart';
import 'package:news_app/model/news-model.dart';

class NewsDetail extends StatelessWidget {
  final News news;
  NewsDetail(this.news);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Image.network(
            news.photoUrl ??
                "https://www.shutterstock.com/image-vector/no-image-photography-vector-icon-means-1736999849",
            fit: BoxFit.fill,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace stackTrace) {
              return Image.asset(
                "images/no-image.png",
                width: 100,
                height: 100,
              );
            },
            scale: 1.5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "\n" + news.title + "\n",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              news.description ?? "--",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
          )
        ],
      ),
    );
  }
}
