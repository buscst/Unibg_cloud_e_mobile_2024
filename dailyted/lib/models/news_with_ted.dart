class Talk {
  final String title;
  final String description;
  final String link;
  final String url;
  final String pubDate;
  final String source_icon;

  Talk.fromJSON(Map<String, dynamic> jsonMap) :
    title = jsonMap['title'],
    description = jsonMap['description'],
    link = (jsonMap['link'] ?? ""),
    url = (jsonMap['url'] ?? ""),
    pubDate = (jsonMap['pubDate'] ?? ""),
    source_icon = (jsonMap['pubDate'] ?? "");
}