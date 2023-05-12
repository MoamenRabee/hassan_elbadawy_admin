class ViewsVideoModel{
  String? lessonId;
  String? videoId;
  String? videoName;
  String? studentName;
  String? studentPhone;
  String? classroomId;
  int? viewsCount;


  ViewsVideoModel({
    required this.lessonId,
    required this.videoId,
    required this.videoName,
    required this.studentName,
    required this.studentPhone,
    required this.classroomId,
    required this.viewsCount,
  });

  ViewsVideoModel.fromJson(Map<String,dynamic> json){
    lessonId = json["lessonId"];
    videoId = json["videoId"];
    videoName = json["videoName"];
    studentName = json["studentName"];
    studentPhone = json["studentPhone"];
    classroomId = json["classroomId"];
    viewsCount = json["viewsCount"];
  }

  Map<String,dynamic> toMap(){
    return {
      "lessonId" : lessonId,
      "videoId" : videoId,
      "videoName" : videoName,
      "studentName" : studentName,
      "studentPhone" : studentPhone,
      "classroomId" : classroomId,
      "viewsCount" : viewsCount,
    };
  }

}