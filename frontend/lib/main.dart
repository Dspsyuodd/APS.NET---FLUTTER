import 'package:flutter/material.dart';
import 'package:frontend/controllers/moderator_controller.dart';
import 'package:frontend/controllers/topics_controller.dart';
import 'package:frontend/home_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const Forum());
}

initialization() async {
  Get.put(ModeratorController());
  var topicController = Get.put(TopicController());
  topicController.getAll();
}

class Forum extends StatelessWidget {
  const Forum({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initialization();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StackOverflow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange[800]!),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
