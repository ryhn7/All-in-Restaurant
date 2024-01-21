import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/utils/config.dart';
import 'package:alice/alice.dart';

class ApiConfig {
  Alice alice = Alice(showNotification: true, navigatorKey: navigatorKey);

  Future<T> getApiService<T>(String path,
      {Map<String, String>? headers,
      T Function(Map<String, dynamic>)? decoder}) async {
    try {
      final response = await http
          .get(Uri.parse(Configuration.Base_Url + '$path'), headers: headers);
      alice.onHttpResponse(response);

      if (response.statusCode == 200) {
        final jsonResult = json.decode(response.body);

        if (decoder != null) {
          return decoder(jsonResult);
        } else {
          throw Exception('Failed to get data');
        }
      } else {
        throw Exception('Failed to get data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Error');
    }
  }

  Future<T> postApiService<T>(String path,
      {Map<String, String>? headers,
      Map<String, dynamic>? body,
      T Function(Map<String, dynamic>)? decoder}) async {
    try {
      final response = await http.post(
          Uri.parse(Configuration.Base_Url + '$path'),
          headers: headers,
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        final jsonResult = json.decode(response.body);

        if (decoder != null) {
          return decoder(jsonResult);
        } else {
          throw Exception('Failed to get data');
        }
      } else {
        throw Exception('Failed to get data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Error');
    }
  }
}
