class ExamModel{
  String? lessonId;
  String? examId;
  String? examName;

  ExamModel({
    required this.lessonId,
    required this.examId,
    required this.examName,
  });

  ExamModel.fromJson(Map<String,dynamic> json){
    lessonId = json["lessonId"];
    examId = json["examId"];
    examName = json["examName"];
  }

  Map<String,dynamic> toMap(){
    return {
      "lessonId" : lessonId,
      "examId" : examId,
      "examName" : examName,
    };
  }
}



class QuestionModel{
  String? questionId;
  String? examId;
  String? question;
  String? questionImage;
  List<dynamic>? answers;
  int? correctAnswer;

  QuestionModel({
    required this.questionId,
    required this.examId,
    required this.question,
    required this.questionImage,
    required this.answers,
    required this.correctAnswer,
  });

  QuestionModel.fromJson(Map<String,dynamic> json){
    questionId = json["questionId"];
    examId = json["examId"];
    question = json["question"];
    questionImage = json["questionImage"];
    answers = json["answers"];
    correctAnswer = json["correctAnswer"];
  }

  Map<String,dynamic> toMap(){
    return {
      "questionId" : questionId,
      "examId" : examId,
      "question" : question,
      "questionImage" : questionImage,
      "answers" : answers,
      "correctAnswer" : correctAnswer,
    };
  }
}