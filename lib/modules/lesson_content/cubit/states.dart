abstract class LessonStates {}

class LessonInitState extends LessonStates {}

class LessonAddVideoLoadingState extends LessonStates {}

class LessonAddVideoSuccessState extends LessonStates {}

class LessonAddVideoErrorState extends LessonStates {
  String err;
  LessonAddVideoErrorState(this.err);
}

class LessonGetVideosLoadingState extends LessonStates {}

class LessonGetVideosSuccessState extends LessonStates {}

class LessonGetVideosErrorState extends LessonStates {
  String err;
  LessonGetVideosErrorState(this.err);
}

class LessonDeleteVideoLoadingState extends LessonStates {}

class LessonDeleteVideoSuccessState extends LessonStates {}

class LessonDeleteVideoErrorState extends LessonStates {
  String err;
  LessonDeleteVideoErrorState(this.err);
}

class LessonEditVideoLoadingState extends LessonStates {}

class LessonEditVideoSuccessState extends LessonStates {}

class LessonEditVideoErrorState extends LessonStates {
  String err;
  LessonEditVideoErrorState(this.err);
}

class AddNewExamLoading extends LessonStates {}

class AddNewExamSuccess extends LessonStates {}

class AddNewExamError extends LessonStates {
  String err;
  AddNewExamError(this.err);
}

class DeleteExamLoading extends LessonStates {}

class DeleteExamSuccess extends LessonStates {}

class DeleteExamError extends LessonStates {
  String err;
  DeleteExamError(this.err);
}

class UpdateExamLoading extends LessonStates {}

class UpdateExamSuccess extends LessonStates {}

class UpdateExamError extends LessonStates {
  String err;
  UpdateExamError(this.err);
}

class GetExamsLoading extends LessonStates {}

class GetExamsSuccess extends LessonStates {}

class GetExamsError extends LessonStates {
  String err;
  GetExamsError(this.err);
}

class GetExamsResultsoading extends LessonStates {}

class GetExamsResultsSuccess extends LessonStates {}

class GetExamsResultsError extends LessonStates {
  String err;
  GetExamsResultsError(this.err);
}

class SelectPDFState extends LessonStates {}

class GetFilesLoading extends LessonStates {}

class GetFilesSuccess extends LessonStates {}

class GetFilesError extends LessonStates {
  String err;
  GetFilesError(this.err);
}

class AddNewFileLoading extends LessonStates {}

class AddNewFileSuccess extends LessonStates {}

class AddNewFileError extends LessonStates {
  String err;
  AddNewFileError(this.err);
}

class DeleteFileLoading extends LessonStates {}

class DeleteFileSuccess extends LessonStates {}

class DeleteFileError extends LessonStates {
  String err;
  DeleteFileError(this.err);
}
