class FileModel{
  String? lessonId;
  String? fileId;
  String? fileName;
  String? fileURL;


  FileModel({
    required this.lessonId,
    required this.fileId,
    required this.fileName,
    required this.fileURL,
  });

  FileModel.fromJson(Map<String,dynamic> json){
    lessonId = json["lessonId"];
    fileId = json["fileId"];
    fileName = json["fileName"];
    fileURL = json["fileURL"];
  }

  Map<String,dynamic> toMap(){
    return {
      "lessonId" : lessonId,
      "fileId" : fileId,
      "fileName" : fileName,
      "fileURL" : fileURL,
    };
  }

}