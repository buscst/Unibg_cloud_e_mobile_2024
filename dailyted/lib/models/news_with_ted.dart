class NewsTed {
  final String id;
  final String articleId;
  final String title;
  final String link;
  final String description;
  final String pubDate;
  final String sourceId;
  final String sourceIcon;

  final String titleTed;
  final String detailsTed;
  final String mainSpeakerTed;
  final String urlTed;

  NewsTed.fromJSON(Map<String, dynamic> jsonMap) :
    id = jsonMap['_id'] ?? '',
    articleId = jsonMap['article_id'] ?? '',
    title = jsonMap['title'] ?? '',
    link = jsonMap['link'] ?? '',
    description = jsonMap['description'] ?? '',
    pubDate = jsonMap['pubDate'] ?? '',
    sourceId = jsonMap['source_id'] ?? '',
    sourceIcon = jsonMap['source_icon'] ?? '',
    titleTed = jsonMap['title'] ?? '',
    detailsTed = jsonMap['description'] ?? '',
    mainSpeakerTed = jsonMap['speakers'] ?? '',
    urlTed = jsonMap['url'] ?? '';
}