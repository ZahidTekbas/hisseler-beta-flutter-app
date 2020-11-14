import 'package:http/http.dart' as http;
import 'dart:convert';

fetchHisseListesi()async{
  var url = "http://bigpara.hurriyet.com.tr/api/v1/hisse/list";

  var response = await http.get(url);

  var json = jsonDecode(response.body);

  return json;
}