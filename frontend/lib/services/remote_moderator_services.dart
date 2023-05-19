import 'package:http/http.dart' as http;

import 'api_client.dart';

class RemoteModeratorService {
  const RemoteModeratorService();
  final _apiClient = const ApiClient();

  Future<http.Response> login(String login, String password) async {
    var response = await _apiClient.getRequest(
      path: '/Moderators/login?login=$login&password=$password',
    );
    return response;
  }

  Future<http.Response> registration(String login, String password, String apiKey) async {
    var path =
        '/Moderators/registration?login=$login&password=$password&apiKey=$apiKey';
    var response = await _apiClient.postRequest(
      path: path,
    );
    return response;
  }
}
