
import 'package:hassan_elbadawy_admin/models/student_model.dart';

class ChatModel {
  String? classroomId;
  String? langId;
  bool? isActive;
  String? centerName;
  String? centerId;

  ChatModel({
    required this.classroomId,
    required this.langId,
    required this.isActive,
    required this.centerName,
    required this.centerId,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    classroomId = json["classroomId"];
    langId = json["langId"];
    isActive = json["isActive"];
    centerName = json["centerName"];
    centerId = json["centerId"];
  }

  Map<String, dynamic> toMap() {
    return {
      "classroomId": classroomId,
      "langId": langId,
      "isActive": isActive,
      "centerName": centerName,
      "centerId": centerId,
    };
  }
}

class MessageModel {
  String? classroomId;
  String? langId;
  String? message;
  String? messageUrl;
  String? dateTime;
  StudentModel? student;

  MessageModel({
    required this.classroomId,
    required this.langId,
    required this.message,
    required this.messageUrl,
    required this.dateTime,
    required this.student,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    classroomId = json["classroomId"];
    langId = json["langId"];
    message = json["message"];
    messageUrl = json["messageUrl"];
    dateTime = json["dateTime"];
    student = json["student"];
  }

  Map<String, dynamic> toMap() {
    return {
      "classroomId": classroomId,
      "langId": langId,
      "message": message,
      "messageUrl": messageUrl,
      "dateTime": dateTime,
      "student": student,
    };
  }
}
