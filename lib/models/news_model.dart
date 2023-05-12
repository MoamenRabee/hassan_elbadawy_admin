class NewsModel{
  String? id;
  String? title;
  String? image;
  String? videoUrl;
  String? content;
  DateTime? date;


  NewsModel({
    required this.id,
    required this.title,
    required this.image,
    required this.videoUrl,
    required this.content,
    required this.date,
  });

  NewsModel.fromJson(Map<String,dynamic> json){
    id = json["id"];
    title = json["title"];
    image = json["image"];
    videoUrl = json["videoUrl"];
    content = json["content"];
    date = json["date"].toDate();
  }

  Map<String,dynamic> toMap(){
    return {
      "id" : id,
      "title" : title,
      "image" : image,
      "videoUrl" : videoUrl,
      "content" : content,
      "date" : date,
    };
  }

}