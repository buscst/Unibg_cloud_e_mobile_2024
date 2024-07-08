import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/news.dart';

Future<List<News>> initEmptyList() async {

  Iterable list = json.decode("[]");
  var news = list.map((model) => News.fromJSON(model)).toList();
  return news;

}

Future<List<News>> getNewsByTag() async {
  var url = Uri.parse('https://ljk9b9je3f.execute-api.us-east-1.amazonaws.com/default/FetchNewsData');

  final http.Response response = await http.post(url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Object>{
    }),
  );
  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    var news = list.map((model) => News.fromJSON(model)).toList();
    return news;
  } else {
    throw Exception('Failed to load talks');
  }
      
}