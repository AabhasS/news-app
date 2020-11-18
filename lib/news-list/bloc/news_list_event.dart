part of 'news_list_bloc.dart';

@immutable
abstract class NewsListEvent {}

class GetNews extends NewsListEvent {
  final String query;
  GetNews({this.query});
}
