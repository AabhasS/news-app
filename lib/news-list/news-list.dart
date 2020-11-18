import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news-list/bloc/news_list_bloc.dart';
import 'package:news_app/widgets/news-tile.dart';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final _scrollController = ScrollController();
  final TextEditingController _editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsListBloc>(
      create: (context) => NewsListBloc(),
      child: BlocBuilder<NewsListBloc, NewsListState>(
        builder: (context, state) {
          Widget _widget = Container();
          if (state is NewsListInitial) {
            BlocProvider.of<NewsListBloc>(context).add(GetNews());
          }

          if (state is NewsListLoaded) {
            _widget = NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollEndNotification &&
                    _scrollController.position.extentAfter == 0) {
                  if (!BlocProvider.of<NewsListBloc>(context).endOfResults)
                    BlocProvider.of<NewsListBloc>(context).add(GetNews());
                }
                return false;
              },
              child: ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: BlocProvider.of<NewsListBloc>(context).endOfResults
                      ? state.newsList.length
                      : state.newsList.length + 1,
                  itemBuilder: (context, int i) {
                    return i >= state.newsList.length
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50.0,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          )
                        : NewsTile(state.newsList[i]);
                  }),
            );
          }

          if (state is NewsListEmpty) {
            _widget = Center(
                child: Text(
              "No results found !!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ));
          }
          return Scaffold(
            appBar: AppBar(
                title: TextField(
              decoration: InputDecoration(
                  hintText: "Search for any news",
                  suffixIcon: Icon(Icons.search),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
              controller: _editingController,
              onChanged: (String query) {
                _editingController.text = query;
                if (query.length > 3 || query.isEmpty) {
                  BlocProvider.of<NewsListBloc>(context).page = 1;
                  BlocProvider.of<NewsListBloc>(context).newsList.clear();
                  BlocProvider.of<NewsListBloc>(context)
                      .add(GetNews(query: query));
                }
              },
            )),
            body: _widget,
          );
        },
      ),
    );
  }
}
