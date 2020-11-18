class News {
  final String title;
  final String photoUrl;
  final String description;

  News({this.title, this.photoUrl, this.description});

  factory News.fromJson(Map<String, dynamic> parsedJson) {
    return News(
        title: parsedJson['title'],
        photoUrl: parsedJson['urlToImage'],
        description: parsedJson['description']);
  }
}
