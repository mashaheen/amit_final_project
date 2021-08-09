import 'dart:convert';

import 'package:amit_final_project/model/errorResponse.dart';
import 'package:http/http.dart';
import 'package:amit_final_project/model/user.dart';

Future<String> register(User user) async {
  var url = Uri.parse("https://retail.amit-learning.com/api/register");
  Response response = await post(url,
      body: jsonEncode(user), headers: {"Content-Type": "application/json"});
  if (response.statusCode == 201) {
    return jsonDecode(response.body)["token"];
  } else if (response.statusCode == 422) {
    Error e = errorFromJson(response.body);
    if (e.errors.email != null) {
      return "1";
    } else {
      return null;
    }
  } else {
    return null;
  }
}

Future<String> login(User user) async {
  var url = Uri.parse("https://retail.amit-learning.com/api/login");
  Response response = await post(url,
      body: jsonEncode(user), headers: {"Content-Type": "application/json"});
  if (response.statusCode == 200) {
    return json.decode(response.body)["token"];
  } else {
    return null;
  }
}

Future<User> getUser(String token) async {
  var url = Uri.parse("https://retail.amit-learning.com/api/user");
  Response response =
      await get(url, headers: {'Authorization': 'Bearer $token'});
  if (response.statusCode == 200) {
    User user = User.fromJson(jsonDecode(response.body));
    user.token = token;
    return user;
  }
  return null;
}
