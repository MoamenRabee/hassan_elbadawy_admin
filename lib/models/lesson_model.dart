class LessonModel{
  String? classroomId;
  String? langId;
  String? lessonId;
  int? lessonOrderNumber;
  String? lessonName;
  String? lessonImage;
  String? lessonPrice;
  bool? isFree;

  LessonModel({
    required this.classroomId,
    required this.langId,
    required this.lessonId,
    required this.lessonOrderNumber,
    required this.lessonName,
    required this.lessonImage,
    required this.lessonPrice,
    required this.isFree,
  });

  LessonModel.fromJson(Map<String,dynamic> json){
    classroomId = json["classroomId"];
    langId = json["langId"];
    lessonId = json["lessonId"];
    lessonOrderNumber = json["lessonOrderNumber"];
    lessonName = json["lessonName"];
    lessonImage = json["lessonImage"];
    lessonPrice = json["lessonPrice"];
    isFree = json["isFree"];
  }

  Map<String,dynamic> toMap(){
    return {
      "classroomId" : classroomId,
      "langId" : langId,
      "lessonId" : lessonId,
      "lessonOrderNumber" : lessonOrderNumber,
      "lessonName" : lessonName,
      "lessonImage" : lessonImage,
      "lessonPrice" : lessonPrice,
      "isFree" : isFree,
    };
  }
}