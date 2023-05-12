part of 'cubit.dart';

@immutable
abstract class MonthlyState {}

class MonthlyInitial extends MonthlyState {}

class ContentChangeLangState extends MonthlyState{}
class ContentChangeClassroomState extends MonthlyState{}

class AddMonthLoading extends MonthlyState {}

class AddMonthSuccess extends MonthlyState {}

class AddMonthError extends MonthlyState {
  String err;
  AddMonthError(this.err);
}

class GetMonthLoading extends MonthlyState {}

class GetMonthSuccess extends MonthlyState {}

class GetMonthError extends MonthlyState {
  String err;
  GetMonthError(this.err);
}

class DeleteMonthLoading extends MonthlyState {}

class DeleteMonthSuccess extends MonthlyState {}

class DeleteMonthError extends MonthlyState {
  String err;
  DeleteMonthError(this.err);
}


class UpdateMonthLoading extends MonthlyState {}

class UpdateMonthSuccess extends MonthlyState {}

class UpdateMonthError extends MonthlyState {
  String err;
  UpdateMonthError(this.err);
}


class GetLessonsInMonthLoading extends MonthlyState {}

class GetLessonsInMonthSuccess extends MonthlyState {}

class GetLessonsInMonthError extends MonthlyState {
  String err;
  GetLessonsInMonthError(this.err);
}

class LessonInMonthLoading extends MonthlyState {}

class LessonInMonthSuccess extends MonthlyState {}

class LessonInMonthError extends MonthlyState {
  String err;
  LessonInMonthError(this.err);
}