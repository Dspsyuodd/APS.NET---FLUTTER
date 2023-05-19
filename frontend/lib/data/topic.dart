import 'dart:convert';

List<Topic> topicFromJson(String str) =>
    List<Topic>.from(json.decode(str).map((x) => Topic.fromJson(x)));

String topicToJson(List<Topic> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Topic {
  int id;
  String name;
  String userName;
  DateTime createAt;

  Topic({
    required this.id,
    required this.name,
    required this.userName,
    required this.createAt,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["id"],
        name: json["name"],
        userName: json["userName"],
        createAt: DateTime.parse(json["createAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "userName": userName,
        "createAt": createAt.toIso8601String(),
      };
}
