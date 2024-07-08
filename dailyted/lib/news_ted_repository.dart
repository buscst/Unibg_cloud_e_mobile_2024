import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/news_with_ted.dart';

Future<List<NewsTed>> initEmptyList() async {

  Iterable list = json.decode("[]");
  var newsted = list.map((model) => NewsTed.fromJSON(model)).toList();
  return newsted;

}

Future<List<NewsTed>> getNewsTedByTag(String id) async {
  var url = Uri.parse('https://ljk9b9je3f.execute-api.us-east-1.amazonaws.com/default/FetchNewsData');

  final http.Response response = await http.post(url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Object>{
      'article_id': id
    }),
  );
  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    var newsted = list.map((model) => NewsTed.fromJSON(model)).toList();
    return newsted;
  } else {
    throw Exception('Failed to load talks');
  }
      
}