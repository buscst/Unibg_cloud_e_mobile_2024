class Talk {
  final String id;
  final String title;
  final String description;
  final String speakers;
  final String url;
  final String urlimg;
  final String duration;
  final List<RelatedTalk> relatedTalks;

  Talk.fromJSON(Map<String, dynamic> jsonMap) :
    id = jsonMap['_id']?? "",
    title = jsonMap['title']?? "",
    description = jsonMap['description']?? "",
    speakers = (jsonMap['speakers'])?? "",
    url = (jsonMap['url'])?? "",
    urlimg = jsonMap['url_image']?? "",
    duration = jsonMap['duration']?? "",
    relatedTalks = (jsonMap['related_videos'] as List)
        .map((talkJson) => RelatedTalk.fromJSON(talkJson))
        .toList();
}

class RelatedTalk {
  final String id;
  final String title;
  final String speakers;
  final String duration;
  final String urlimg;

  RelatedTalk.fromJSON(Map<String, dynamic> jsonMap) :
    id = jsonMap['_id']?? "",
    title = jsonMap['title']?? "",
    speakers = (jsonMap['speakers'])?? "",
    urlimg = jsonMap['url_image']?? "",
    duration = jsonMap['duration']?? "";
}