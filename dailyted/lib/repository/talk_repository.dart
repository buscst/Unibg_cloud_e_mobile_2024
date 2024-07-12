import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/talk.dart';

Future<List<Talk>> initEmptyList() async {

  Iterable list = json.decode("[]");
  var talks = list.map((model) => Talk.fromJSON(model)).toList();
  return talks;
}

Future<List<Talk>> getTalksByTag(String tag, int page) async {
  var url = Uri.parse('https://3as5hf1qd3.execute-api.us-east-1.amazonaws.com/default/Get_Talks_By_Tag');

  final http.Response response = await http.post(url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Object>{
      'tag': tag,
      'page': page,
      'doc_per_page': 6
    }),
  );
  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    var talks = list.map((model) => Talk.fromJSON(model)).toList();
    return talks;
  } else {
    throw Exception('Failed to load talks');
  } 
}

Future<Talk> getTalksByID(String id) async {
  var url = Uri.parse('https://3gozd8z8uj.execute-api.us-east-1.amazonaws.com/default/Get_Talk_By_Id?_id='+id);

  final http.Response response = await http.get(url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    Talk res=Talk.fromJSON(json.decode(response.body));
    print(res.speakers);
    print(res.description);
    return  res;
  } else {
    throw Exception('Failed to load talks');
  }
      
}