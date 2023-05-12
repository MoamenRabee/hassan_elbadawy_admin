class CodeModel {
  String? groupId;
  String? code;
  String? codePrice;
  bool? isUsed;
  String? usedBy;
  String? usedByStudentName;
  String? lessonId;
  String? lessonName;
  String? usedTime;

  CodeModel({
    required this.groupId,
    required this.code,
    required this.codePrice,
    required this.isUsed,
    required this.usedBy,
    required this.usedByStudentName,
    required this.lessonId,
    required this.lessonName,
    required this.usedTime,
  });

  CodeModel.fromJson(Map<String, dynamic> json) {
    groupId = json["groupId"];
    code = json["code"];
    codePrice = json["codePrice"];
    isUsed = json["isUsed"];
    usedBy = json["usedBy"];
    usedByStudentName = json["usedByStudentName"];
    lessonId = json["lessonId"];
    lessonName = json["lessonName"];
    usedTime = json["usedTime"];
  }

  Map<String, dynamic> toMap() {
    return {
      "groupId": groupId,
      "code": code,
      "codePrice": codePrice,
      "isUsed": isUsed,
      "usedBy": usedBy,
      "usedByStudentName": usedByStudentName,
      "lessonId": lessonId,
      "lessonName": lessonName,
      "usedTime": usedTime,
    };
  }
}
