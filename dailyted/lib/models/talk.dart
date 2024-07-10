class Talk {
  final String title;
  final String details;
  final String mainSpeaker;
  final String url;
  final String duration;

  Talk.fromJSON(Map<String, dynamic> jsonMap) :
    title = jsonMap['title'],
    details = jsonMap['description'],
    mainSpeaker = (jsonMap['speakers'] ?? ""),
    url = (jsonMap['url'] ?? ""),
    duration = jsonMap['duration'];
}

class RelatedTalk {
  final String title;
  final String details;
  final String mainSpeaker;
  final String url;
  final String duration;
  final String urlimg;

  RelatedTalk.fromJSON(Map<String, dynamic> jsonMap) :
    title = jsonMap['5']?? "",
    details = jsonMap['7']?? "",
    mainSpeaker = (jsonMap['4'] ?? ""),
    url = (jsonMap['3'] ?? ""),
    urlimg = jsonMap['1']?? "",
    duration = jsonMap['8']?? "";
}