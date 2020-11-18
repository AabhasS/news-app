import 'package:dio/dio.dart';
import 'package:news_app/model/news-model.dart';

class NewsService {
  Dio dio = Dio();

  Future<List<News>> getNews({int page, int pageSize, String query}) async {
    Response response = await dio.get(
        "http://newsapi.org/v2/top-headlines?country=in&pagesize=${pageSize ?? 10}&page=$page&q=${query ?? ""}&apiKey=cd4d3388eb854e3b84ace7f5dabb30b7");
    List<dynamic> list = response.data["articles"];

    return Future.value(list.map((e) => News.fromJson(e)).toList());
  }
}
