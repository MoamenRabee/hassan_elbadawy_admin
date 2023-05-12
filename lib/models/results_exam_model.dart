class ResultsExamModel{
  String? resultId;
  String? lessonId;
  String? examId;
  String? examName;
  String? studentPhone;
  String? studentName;
  DateTime? createdAt;
  int? studentResult;
  int? questionsCount;


  ResultsExamModel({
    required this.resultId,
    required this.lessonId,
    required this.examId,
    required this.examName,
    required this.studentPhone,
    required this.studentName,
    required this.createdAt,
    required this.studentResult,
    required this.questionsCount,
  });

  ResultsExamModel.fromJson(Map<String,dynamic> json){
    resultId = json["resultId"];
    lessonId = json["lessonId"];
    examId = json["examId"];
    examName = json["examName"];
    studentPhone = json["studentPhone"];
    studentName = json["studentName"];
    createdAt = json["createdAt"].toDate();
    studentResult = json["studentResult"];
    questionsCount = json["questionsCount"];
  }

  Map<String,dynamic> toMap(){
    return {
      "resultId" : resultId,
      "lessonId" : lessonId,
      "examId" : examId,
      "examName" : examName,
      "studentPhone" : studentPhone,
      "studentName" : studentName,
      "createdAt" : createdAt,
      "studentResult" : studentResult,
      "questionsCount" : questionsCount,
    };
  }
}




class ResultTextQuestionModel{
  String? resultId;
  String? lessonId;
  String? textResultId;
  String? classroomId;
  String? subjectId;
  String? teacherId;
  String? examId;
  String? examName;
  String? studentPhone;
  String? studentName;
  String? textQuestion;
  String? textAnswer;
  dynamic studentResult;
  bool? isReviewed;


  ResultTextQuestionModel({
    required this.resultId,
    required this.textResultId,
    required this.lessonId,
    required this.classroomId,
    required this.subjectId,
    required this.teacherId,
    required this.examId,
    required this.examName,
    required this.studentPhone,
    required this.studentName,
    required this.textQuestion,
    required this.textAnswer,
    required this.studentResult,
    required this.isReviewed,

  });

  ResultTextQuestionModel.fromJson(Map<String,dynamic> json){
    resultId = json["resultId"];
    textResultId = json["textResultId"];
    lessonId = json["lessonId"];
    classroomId = json["classroomId"];
    subjectId = json["subjectId"];
    teacherId = json["teacherId"];
    examId = json["examId"];
    examName = json["examName"];
    studentPhone = json["studentPhone"];
    studentName = json["studentName"];
    textQuestion = json["textQuestion"];
    textAnswer = json["textAnswer"];
    studentResult = json["studentResult"];
    isReviewed = json["isReviewed"];
  }

  Map<String,dynamic> toMap(){
    return {
      "resultId" : resultId,
      "textResultId" : textResultId,
      "lessonId" : lessonId,
      "classroomId" : classroomId,
      "subjectId" : subjectId,
      "teacherId" : teacherId,
      "examId" : examId,
      "examName" : examName,
      "studentPhone" : studentPhone,
      "studentName" : studentName,
      "textQuestion" : textQuestion,
      "textAnswer" : textAnswer,
      "studentResult" : studentResult,
      "isReviewed" : isReviewed,
    };
  }
}
