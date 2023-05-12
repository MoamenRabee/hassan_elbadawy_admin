class CommentModel{
  String? videoId;
  String? videoName;
  String? studentPhone;
  String? studentName;
  String? comment;
  String? commentId;
  DateTime? time;


  CommentModel({
    required this.videoId,
    required this.videoName,
    required this.studentPhone,
    required this.studentName,
    required this.comment,
    required this.commentId,
    required this.time,
  });

  CommentModel.fromJson(Map<String,dynamic> json){
    videoId = json["videoId"];
    videoName = json["videoName"];
    studentPhone = json["studentPhone"];
    studentName = json["studentName"];
    comment = json["comment"];
    commentId = json["commentId"];
    time = json["time"].toDate();
  }

  Map<String,dynamic> toMap(){
    return {
      "videoId" : videoId,
      "videoName" : videoName,
      "studentPhone" : studentPhone,
      "studentName" : studentName,
      "comment" : comment,
      "commentId" : commentId,
      "time" : time,
    };
  }

}