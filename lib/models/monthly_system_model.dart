class MonthlySystemModel {
  String? classroomId;
  String? langId;
  String? systemId;
  int? systemOrderNumber;
  String? systemName;
  String? systemPrice;
  List<dynamic>? lessons;

  MonthlySystemModel({
    required this.classroomId,
    required this.systemId,
    required this.langId,
    required this.systemOrderNumber,
    required this.systemName,
    required this.systemPrice,
    required this.lessons,
  });

  MonthlySystemModel.fromJson(Map<String, dynamic> json) {
    classroomId = json["classroomId"];
    systemId = json["systemId"];
    langId = json["langId"];
    systemOrderNumber = json["systemOrderNumber"];
    systemName = json["systemName"];
    systemPrice = json["systemPrice"];
    lessons = List<dynamic>.from(json['lessons']).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      "classroomId": classroomId,
      "systemId": systemId,
      "langId": langId,
      "systemOrderNumber": systemOrderNumber,
      "systemName": systemName,
      "systemPrice": systemPrice,
      "lessons": lessons,
    };
  }
}
