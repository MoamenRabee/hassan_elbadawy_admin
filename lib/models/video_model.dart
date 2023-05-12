class VideoModel {
  String? lessonId;
  String? videoId;
  int? videoOrderNumber;
  String? videoName;
  String? videoDesc;
  String? videoURL;
  int? viewsCount;

  VideoModel({
    required this.lessonId,
    required this.videoId,
    required this.videoOrderNumber,
    required this.videoName,
    required this.videoDesc,
    required this.videoURL,
    required this.viewsCount,
  });

  VideoModel.fromJson(Map<String, dynamic> json) {
    lessonId = json["lessonId"];
    videoId = json["videoId"];
    videoOrderNumber = json["videoOrderNumber"];
    videoName = json["videoName"];
    videoDesc = json["videoDesc"];
    videoURL = json["videoURL"];
    viewsCount = json["viewsCount"];
  }

  Map<String, dynamic> toMap() {
    return {
      "lessonId": lessonId,
      "videoId": videoId,
      "videoOrderNumber": videoOrderNumber,
      "videoName": videoName,
      "videoDesc": videoDesc,
      "videoURL": videoURL,
      "viewsCount": viewsCount,
    };
  }
}
