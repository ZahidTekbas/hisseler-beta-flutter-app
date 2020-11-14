import 'package:http/http.dart' as http;
import 'dart:convert';
fetchHisse(String kod)async{
  var url = "http://bigpara.hurriyet.com.tr/api/v1/borsa/hisseyuzeysel/$kod";

  var response = await http.get(url);

  var json = jsonDecode(response.body);

  return await json;
}