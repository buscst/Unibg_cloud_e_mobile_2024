import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/news_with_ted.dart';

Future<NewsTed> getNewsTed(String id) async {
  var url = Uri.parse("https://2a9917r8f0.execute-api.us-east-1.amazonaws.com/default/Get_All_News_With_Talks?article_id="+id);
  final http.Response response = await http.get(url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    print(response.body);
    NewsTed res=NewsTed.fromJSON(json.decode(response.body));
    print(res.talks.length);
    return  res;
  } else {
    print("prova");
    throw Exception('Failed to load talks');
  }
      
}