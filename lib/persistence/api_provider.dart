import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class API{
  Future login(String url,String email,String password) async {
    SharedPreferences _pref =await SharedPreferences.getInstance();
    Map <String,dynamic> body={"url":url, "login":email, "password":password};
    final response = await http.post("https://$url/web/session/authenticate",body: body);
    print(response.body.toString());
    if (response.statusCode == 200) {
      _pref.setString("Domain", url);
      var data=json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load Data');
    }
  }
}