part of 'news_list_bloc.dart';

@immutable
abstract class NewsListState {}

class NewsListInitial extends NewsListState {}

class NewsListLoading extends NewsListState {}

class NewsListLoaded extends NewsListState {
  final List<News> newsList;

  NewsListLoaded(this.newsList);
}

class NewsListEmpty extends NewsListState {}
