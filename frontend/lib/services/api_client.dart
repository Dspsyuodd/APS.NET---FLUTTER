import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiClient {
  static const ip = 'https://localhost:7297/api';
  static const authority = 'localhost:7297';
  static final client = http.Client();
  const ApiClient();

  Future<http.Response> getRequest({required String path}) async {
    final url = Uri.parse(ip + path);
    final response = await client.get(url);
    log(ip + path);
    log(response.body);
    log(response.request.toString());
    return response;
  }

  Future<http.Response> postRequest({required String path}) async {
    final url = Uri.parse(ip + path);
    var response = await client.post(
      url,
    );
    log(ip + path);
    log(response.body);
    log(response.request.toString());
    return response;
  }
}
