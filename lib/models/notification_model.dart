class NotificationModel {
  String? id;
  String? topic;
  String? title;
  String? body;
  DateTime? dateTime;

  NotificationModel({
    required this.id,
    required this.topic,
    required this.title,
    required this.body,
    required this.dateTime,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    topic = json["topic"];
    title = json["title"];
    body = json["body"];
    dateTime = json["dateTime"].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "topic": topic,
      "title": title,
      "body": body,
      "dateTime": dateTime,
    };
  }
}
