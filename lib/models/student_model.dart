import 'dart:convert';

class StudentModel {
  String? studentName;
  String? studentPhone;
  String? studentPassword;
  String? fatherPhone;
  int? classroomId;
  String? langId;
  String? deviceId;
  String? centerId;
  String? centerName;
  String? studentFCM;

  StudentModel({
    this.studentName,
    this.studentPhone,
    this.studentPassword,
    this.fatherPhone,
    this.classroomId,
    this.langId,
    this.deviceId,
    this.centerId,
    this.centerName,
    this.studentFCM,
  });

  StudentModel.fromJson(Map<String, dynamic> json) {
    studentName = json["studentName"];
    studentPhone = json["studentPhone"];
    studentPassword = json["studentPassword"];
    fatherPhone = json["fatherPhone"];
    classroomId = json["classroomId"];
    langId = json["langId"];
    deviceId = json["deviceId"];
    centerId = json["centerId"];
    centerName = json["centerName"];
    studentFCM = json["studentFCM"];
  }


  Map<String, dynamic> toMap() {
    return {
      "studentName": studentName,
      "studentPhone": studentPhone,
      "studentPassword": studentPassword,
      "fatherPhone": fatherPhone,
      "classroomId": classroomId,
      "langId": langId,
      "deviceId": deviceId,
      "centerId": centerId,
      "centerName": centerName,
      "studentFCM": studentFCM,
    };
  }
}
