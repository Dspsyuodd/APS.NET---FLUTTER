import 'dart:convert';

import 'package:frontend/data/topic.dart';
import 'package:frontend/services/remote_topics_services.dart';
import 'package:get/get.dart';

class TopicController extends GetxController {
  final remoteServices = const RemoteTopicServices();
  final _topics = <Topic>[].obs;

  List<Topic> get topics => _topics;

  Future<void> create(String topicName, String userName) async {
    var response = await remoteServices.create(topicName, userName);
    _topics.add(Topic.fromJson(jsonDecode(response.body)));
  }

  Future<void> getAll() async {
    var responce = await remoteServices.getAll();
    _topics.addAll(
      List<Topic>.from(
        json.decode(responce.body).map(
              (x) => Topic.fromJson(x),
            ),
      ),
    );
  }
}
