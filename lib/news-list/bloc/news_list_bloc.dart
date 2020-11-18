import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/model/news-model.dart';
import 'package:news_app/service/news-service.dart';

part 'news_list_event.dart';
part 'news_list_state.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  List<News> newsList = new List();
  bool endOfResults = false;

  NewsListBloc() : super(NewsListInitial());
  NewsService newsService = NewsService();
  int page = 1;
  @override
  Stream<NewsListState> mapEventToState(
    NewsListEvent event,
  ) async* {
    if (event is GetNews) {
      yield* _getNews(event.query);
    }
  }

  Stream<NewsListState> _getNews(String query) async* {
    List<News> list = await newsService.getNews(page: page, query: query);
    newsList.addAll(list);
    endOfResults = list.length == 0 ? true : false;
    if (list.length == 0 && page == 1) {
      yield NewsListEmpty();
    } else {
      yield NewsListLoaded(newsList);
    }
    page += 1;
  }
}
