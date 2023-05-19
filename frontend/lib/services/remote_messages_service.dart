import 'package:http/http.dart' as http;

import 'api_client.dart';

class RemoteMessagesService {
  const RemoteMessagesService();
  final _apiClient = const ApiClient();

  Future<http.Response> getMessages(int topicId) async {
    var response = await _apiClient.getRequest(
      path: '/Messages/get_messages?topicId=$topicId',
    );
    return response;
  }

  Future<http.Response> create(String text, int topicId, String userName,
      {int? parentId}) async {
    var path = '/Messages/create?text=$text&topicId=$topicId&userName=$userName';
    if (parentId != null) {
      path += '&parentId=$parentId';
    }
    var response = await _apiClient.postRequest(
      path: path,
    );
    return response;
  }

  Future<http.Response> delete(String apiKey, int messageId) async {
    var path = '/Messages/delete?apiKey=$apiKey&messageId=$messageId';
    var response = await _apiClient.postRequest(
      path: path,
    );
    return response;
  }
}
