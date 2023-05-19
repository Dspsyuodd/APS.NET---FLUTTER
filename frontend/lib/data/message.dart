// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

List<Message> messageFromJson(String str) =>
    List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));

String messageToJson(List<Message> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
  int id;
  int topicId;
  int parentId;
  String userName;
  String text;
  DateTime createAt;

  Message({
    required this.id,
    required this.topicId,
    required this.parentId,
    required this.userName,
    required this.text,
    required this.createAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        topicId: json["topicId"],
        parentId: json["parentId"],
        userName: json["userName"],
        text: json["text"],
        createAt: DateTime.parse(json["createAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "topicId": topicId,
        "parentId": parentId,
        "userName": userName,
        "text": text,
        "createAt": createAt.toIso8601String(),
      };
}
