class CodesGroupModel {
  String? id;
  String? title;
  DateTime? dateTime;
  bool? isPrinted;

  CodesGroupModel({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.isPrinted,
  });

  CodesGroupModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    dateTime = json["dateTime"].toDate();
    isPrinted = json["isPrinted"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "dateTime": dateTime,
      "isPrinted": isPrinted,
    };
  }
}
