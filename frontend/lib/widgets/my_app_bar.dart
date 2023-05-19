import 'package:flutter/material.dart';
import 'package:frontend/controllers/moderator_controller.dart';
import 'package:frontend/controllers/topics_controller.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key, this.size, this.showButtons = true})
      : super(key: key);
  final double? size;
  final bool showButtons;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          height: 5,
          decoration: BoxDecoration(
            color: theme.primaryColor,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Image.asset(
                        'assets/1280px-Stack_Overflow_logo.svg.png',
                        scale: 6,
                      ),
                    ),
                    showButtons
                        ? Container(
                            decoration: BoxDecoration(
                                color: theme.colorScheme.secondaryContainer,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                                border: Border.all(color: theme.primaryColor)),
                            width: 300,
                            height: 50,
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                showButtons
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: SizedBox(
                            width: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      var topicName = '';
                                      var userName = '';
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('New topic'),
                                              content: SizedBox(
                                                height: 100,
                                                child: Column(
                                                  children: [
                                                    TextField(
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText:
                                                            'Theme of topic',
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                      onChanged: (value) {
                                                        topicName = value;
                                                      },
                                                    ),
                                                    TextField(
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText:
                                                            'Your username',
                                                        border:
                                                            InputBorder.none,
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
                                                    await Get.find<
                                                            TopicController>()
                                                        .create(topicName,
                                                            userName);
                                                    Get.back();
                                                  },
                                                  child: const Text('Done'),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: const Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Icon(Icons.add),
                                        ),
                                        Text('Add new topik'),
                                      ],
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => !Get.find<ModeratorController>()
                                          .isModerator
                                      ? ElevatedButton(
                                          onPressed: () {
                                            var login = '';
                                            var password = '';
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text('Login'),
                                                    content: SizedBox(
                                                      height: 100,
                                                      child: Column(
                                                        children: [
                                                          TextField(
                                                            decoration:
                                                                const InputDecoration(
                                                              hintText: 'login',
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                            onChanged: (value) {
                                                              login = value;
                                                            },
                                                          ),
                                                          TextField(
                                                            decoration:
                                                                const InputDecoration(
                                                              hintText:
                                                                  'password',
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                            onChanged: (value) {
                                                              password = value;
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          await Get.find<
                                                                  ModeratorController>()
                                                              .login(login,
                                                                  password);
                                                          Get.back();
                                                        },
                                                        child:
                                                            const Text('Done'),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: const Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                                child: Icon(Icons.login),
                                              ),
                                              Text('Login as moderator'),
                                            ],
                                          ),
                                        )
                                      : ElevatedButton(
                                          onPressed: () {
                                            var login = '';
                                            var password = '';
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Add new moderator'),
                                                    content: SizedBox(
                                                      height: 100,
                                                      child: Column(
                                                        children: [
                                                          TextField(
                                                            decoration:
                                                                const InputDecoration(
                                                              hintText: 'login',
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                            onChanged: (value) {
                                                              login = value;
                                                            },
                                                          ),
                                                          TextField(
                                                            decoration:
                                                                const InputDecoration(
                                                              hintText:
                                                                  'password',
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                            onChanged: (value) {
                                                              password = value;
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          await Get.find<
                                                                  ModeratorController>()
                                                              .registration(
                                                                  login,
                                                                  password);
                                                          Get.back();
                                                        },
                                                        child:
                                                            const Text('Done'),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: const Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                                child: Icon(Icons.login),
                                              ),
                                              Text('Add new moderator'),
                                            ],
                                          ),
                                        ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(size ?? 100);
}
