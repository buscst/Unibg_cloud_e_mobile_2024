class News {
  final String id;
  final String articleId;
  final String title;
  final String pubDate;
  final String sourceIcon;

  News.fromJSON(Map<String, dynamic> jsonMap) :
    id = jsonMap['_id'],
    articleId = jsonMap['article_id'],
    title = jsonMap['title']?? "",
    pubDate = jsonMap['pubDate'] ?? "",
    sourceIcon = jsonMap['source_icon'] ?? "";
}