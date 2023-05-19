import 'package:flutter/material.dart';
import 'package:frontend/controllers/messages_controller.dart';
import 'package:frontend/controllers/moderator_controller.dart';
import 'package:frontend/data/message.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'data/topic.dart';

class TopicPage extends StatelessWidget {
  const TopicPage({Key? key, required this.topic}) : super(key: key);
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    var controller = MessagesController(topic.id);
    controller.getMessages();
    return Scaffold(
      appBar: const MyAppBar(
        showButtons: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            topic.name,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Column(
                            children: [
                              Text(
                                DateFormat('yMMMMd').format(topic.createAt),
                              ),
                              TextButton(
                                onPressed: () {
                                  var text = '';
                                  var userName = '';
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Reply'),
                                        content: SizedBox(
                                          height: 100,
                                          child: Column(
                                            children: [
                                              TextField(
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Message',
                                                  border: InputBorder.none,
                                                ),
                                                onChanged: (value) {
                                                  text = value;
                                                },
                                              ),
                                              TextField(
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Your username',
                                                  border: InputBorder.none,
                                                ),
                                                onChanged: (value) {
                                                  userName = value;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              if (text == '' ||
                                                  userName == '') {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return const AlertDialog(
                                                        title: Text(
                                                            'All fields must be filled!'),
                                                      );
                                                    });
                                              } else {
                                                await controller.create(
                                                  text,
                                                  userName,
                                                );
                                                Get.back();
                                              }
                                            },
                                            child: const Text('Done'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text('Reply'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(topic.userName),
                    ],
                  ),
                ),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: buildMessages(controller.messages, controller),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> buildMessages(
    List<Message> messages, MessagesController controller) {
  return messages
      .where((element) => element.parentId == -1)
      .map((e) => MessageBox(
            controller: controller,
            message: e,
          ))
      .toList();
}

class MessageBox extends StatelessWidget {
  const MessageBox({Key? key, required this.message, required this.controller})
      : super(key: key);
  final Message message;
  final MessagesController controller;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          message.text,
                          style: theme.textTheme.headlineSmall,
                        ),
                      ),
                      Text(
                        message.userName,
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        DateFormat('yMMMMd').format(message.createAt),
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          var text = '';
                          var userName = '';
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Reply'),
                                  content: SizedBox(
                                    height: 100,
                                    child: Column(
                                      children: [
                                        TextField(
                                          decoration: const InputDecoration(
                                            hintText: 'Message',
                                            border: InputBorder.none,
                                          ),
                                          onChanged: (value) {
                                            text = value;
                                          },
                                        ),
                                        TextField(
                                          decoration: const InputDecoration(
                                            hintText: 'Your username',
                                            border: InputBorder.none,
                                          ),
                                          onChanged: (value) {
                                            userName = value;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (text == '' || userName == '') {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const AlertDialog(
                                                  title: Text(
                                                      'All fields must be filled!'),
                                                );
                                              });
                                        } else {
                                          await controller.create(
                                              text, userName,
                                              parentId: message.id);
                                          Get.back();
                                        }
                                      },
                                      child: const Text('Done'),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: const Text('Reply'),
                      ),
                      Get.find<ModeratorController>().isModerator == true
                          ? TextButton(
                              onPressed: () {
                                controller.delete(Get.find<ModeratorController>().apiKey, message.id);
                              },
                              child: const Text('Delete message'),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Obx(() => Column(
            children: controller.messages
              .where((element) => element.parentId == message.id)
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(left: 100, right: 10),
                  child: MessageBox(message: e, controller: controller),
                ),
              ).toList(),
          ),),
        ],
      ),
    );
  }
}
