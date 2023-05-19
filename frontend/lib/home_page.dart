import 'package:flutter/material.dart';
import 'package:frontend/controllers/topics_controller.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/topic_bar.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topicController = Get.find<TopicController>();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 100, right: 100),
          child: Obx(
            () => Column(
              children: topicController.topics
                  .map((e) => TopicBar(topic: e))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
