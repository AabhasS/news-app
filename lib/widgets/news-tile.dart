import 'package:flutter/material.dart';
import 'package:news_app/model/news-model.dart';
import 'package:news_app/news-detail/news-detail.dart';

class NewsTile extends StatelessWidget {
  final News news;
  NewsTile(this.news);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NewsDetail(news)));
      },
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              news.photoUrl ??
                  "https://www.shutterstock.com/image-vector/no-image-photography-vector-icon-means-1736999849",
              fit: BoxFit.fill,
              width: 100,
              height: 100,
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
          ),
          title: Text(
            news.title ?? "--",
            // maxLines: 3,
            // overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
