import 'dart:convert';
import 'dart:developer';

import 'package:bloc_api_project/Features/Home/Models/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepo {
  static Future<List<Result>> fetchUserData(int page) async {
    try {
      final response = await http.get(Uri.parse(
          'https://randomuser.me/api/?page=$page&results=10&seed=abc'));
      print('API CALLED-$page');
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDataMap = jsonDecode(response.body);
        List<Result> results = UserData.fromJson(jsonDataMap).results;
        return results;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
