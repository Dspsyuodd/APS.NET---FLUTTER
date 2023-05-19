import 'package:http/http.dart' as http;

import 'api_client.dart';

class RemoteTopicServices {
  const RemoteTopicServices();
  final _apiClient = const ApiClient();

  Future<http.Response> create(String topicName, String userName) async {
    var response = await _apiClient.postRequest(
      path: '/Topics/create?topicName=$topicName&userName=$userName',
    );
    return response;
  }

  Future<http.Response> getAll() async {
    var response = await _apiClient.getRequest(path: '/Topics/get_all');
    return response;
  }

  Future<http.Response> getInfo(String topicId) async {
    var response = await _apiClient.getRequest(path: '/Topics/get_info/?id=$topicId');
    return response;
  }
}
