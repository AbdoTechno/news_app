import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/core/datasource/remote_data/api_config.dart';

abstract class BaseApiService {
  Future<dynamic> get(String endPoint, {Map<String, dynamic>? endPointsParam});
}

class ApiService implements BaseApiService {


  @override
  Future<dynamic> get(
    String endPoint, {
    Map<String, dynamic>? endPointsParam,
  }) async {
    final url = Uri.http(ApiConfig.baseUrl, "v2/$endPoint", {
      "apiKey": ApiConfig.apiKey,
      ...?endPointsParam,
    });
    try {
      final http.Response response = await http.get(url);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } on Exception {
      throw Exception("Failed to load data");
    }
  }
}
