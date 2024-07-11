class Talk {
  final String id;
  final String title;
  final String details;
  final String mainSpeaker;
  final String url;
  final String urlimg;
  final String duration;


  Talk.fromJSON(Map<String, dynamic> jsonMap) :
    id= jsonMap['0']??"",
    title = jsonMap['5']?? "",
    details = jsonMap['7']?? "",
    mainSpeaker = (jsonMap['4'] ?? ""),
    url = (jsonMap['3'] ?? ""),
    urlimg = jsonMap['1']?? "",
    duration = jsonMap['8']?? "";
}

class NewsTed {
  final String id;
  final String articleId;
  final String title;
  final String link;
  final String description;
  final String pubDate;
  final String sourceId;
  final String sourceIcon;
  final List<Talk> talks;


  NewsTed.fromJSON(Map<String, dynamic> jsonMap) :
    id = jsonMap['_id'] ?? '',
    articleId = jsonMap['article_id'] ?? '',
    title = jsonMap['title'] ?? '',
    link = jsonMap['link'] ?? '',
    description = jsonMap['description'] ?? '',
    pubDate = jsonMap['pubDate'] ?? '',
    sourceId = jsonMap['source_id'] ?? '',
    sourceIcon = jsonMap['source_icon'] ?? '',
    talks = (jsonMap['talks'] as List)
          .map((talkJson) => Talk.fromJSON(talkJson))
          .toList();
}