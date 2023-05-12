part of 'qustion_cubit.dart';

@immutable
abstract class QustionState {}

class QustionInitial extends QustionState {}

class SelectAnswerState extends QustionState {}
class SelectImageState extends QustionState {}

class AddQustionLoading extends QustionState {}
class AddQustionSuccess extends QustionState {}
class AddQustionError extends QustionState {
  String err;
  AddQustionError(this.err);
}


class EditQustionLoading extends QustionState {}
class EditQustionSuccess extends QustionState {}
class EditQustionError extends QustionState {
  String err;
  EditQustionError(this.err);
}


class DeleteQustionLoading extends QustionState {}
class DeleteQustionSuccess extends QustionState {}
class DeleteQustionError extends QustionState {
  String err;
  DeleteQustionError(this.err);
}



class GetQuestionsLoading extends QustionState {}
class GetQuestionsSuccess extends QustionState {}
class GetQuestionsError extends QustionState {
  String err;
  GetQuestionsError(this.err);
}