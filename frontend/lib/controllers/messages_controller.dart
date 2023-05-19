import 'dart:convert';

import 'package:frontend/data/message.dart';
import 'package:frontend/services/remote_messages_service.dart';
import 'package:get/get.dart';

class MessagesController extends GetxController {
  final remoteServices = const RemoteMessagesService();
  final int _topicId;
  MessagesController(this._topicId);
  final _messages = <Message>[].obs;

  List<Message> get messages => _messages;

  Future<void> getMessages() async {
    var responce = await remoteServices.getMessages(_topicId);
    _messages.clear();
    _messages.addAll(
      List<Message>.from(
        json.decode(responce.body).map(
              (x) => Message.fromJson(x),
            ),
      ),
    );
  }

  Future<void> create(String text, String userName, {int? parentId}) async {
    var responce = await remoteServices.create(text, _topicId, userName, parentId: parentId);
    _messages.add(Message.fromJson(json.decode(responce.body)));
    _messages.refresh();
  }

  Future<void> delete(String apiKey, int messageId) async {
    var responce = await remoteServices.delete(apiKey, messageId);
    await getMessages();
    // _messages.refresh();
  }
}
