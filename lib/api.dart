import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getFilmes(String filme) async {
  var url = Uri.parse('https://www.omdbapi.com/?s=${filme}&apikey=5c6d8952');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Erro na solicitação: ${response.statusCode}');
  }
}
Future<Map<String, dynamic>> getFilme(String filme) async {
  var url = Uri.parse('https://www.omdbapi.com/?i=${filme}&apikey=5c6d8952');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Erro na solicitação: ${response.statusCode}');
  }
}
