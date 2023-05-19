import 'package:flutter/material.dart';
import 'package:frontend/data/topic.dart';
import 'package:frontend/topic_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TopicBar extends StatelessWidget {
  const TopicBar(
      {Key? key, required this.topic, })
      : super(key: key);
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Get.to(() => TopicPage(topic: topic));
        },
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                offset: Offset(0.0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic.name,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Asked by: ${topic.userName}'),
                    Text(DateFormat('yMMMMd').format(topic.createAt)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
