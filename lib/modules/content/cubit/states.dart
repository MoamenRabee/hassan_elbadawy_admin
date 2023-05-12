abstract class ContentStates{}


class ContentInitState extends ContentStates{}

class ContentChangeLangState extends ContentStates{}
class ContentChangeClassroomState extends ContentStates{}
class ContentChangeTermState extends ContentStates{}



class ContentAddLessonLoadingState extends ContentStates{}
class ContentAddLessonSuccessState extends ContentStates{}
class ContentAddLessonErrorState extends ContentStates{
  String err;
  ContentAddLessonErrorState(this.err);
}

class ContentChangeIsFreeState extends ContentStates{}
class SelectImageState extends ContentStates{}


class ContentEditLessonLoadingState extends ContentStates{}
class ContentEditLessonSuccessState extends ContentStates{}
class ContentEditLessonErrorState extends ContentStates{
  String err;
  ContentEditLessonErrorState(this.err);
}

class ContentGetLessonsLoadingState extends ContentStates{}
class ContentGetLessonsSuccessState extends ContentStates{}
class ContentGetLessonsErrorState extends ContentStates{
  String err;
  ContentGetLessonsErrorState(this.err);
}

class ContentDeleteLessonLoadingState extends ContentStates{}
class ContentDeleteLessonSuccessState extends ContentStates{}
class ContentDeleteLessonErrorState extends ContentStates{
  String err;
  ContentDeleteLessonErrorState(this.err);
}
