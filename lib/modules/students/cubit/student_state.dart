part of 'student_cubit.dart';

@immutable
abstract class StudentState {}

class StudentInitial extends StudentState {}


class SearchInStudents extends StudentState {}



class GetStudentsLoading extends StudentState {}
class GetStudentsSuccess extends StudentState {}
class GetStudentsError extends StudentState {
  String err;
  GetStudentsError(this.err);
}

class UpdateStudentsLoading extends StudentState {}
class UpdateStudentsSuccess extends StudentState {}
class UpdateStudentsError extends StudentState {
  String err;
  UpdateStudentsError(this.err);
}

class ReNewStudentsLoading extends StudentState {}
class ReNewStudentsSuccess extends StudentState {}
class ReNewStudentsError extends StudentState {
  String err;
  ReNewStudentsError(this.err);
}

class DeleteStudentsLoading extends StudentState {}
class DeleteStudentsSuccess extends StudentState {}
class DeleteStudentsError extends StudentState {
  String err;
  DeleteStudentsError(this.err);
}


class GetViewsLoading extends StudentState {}
class GetViewsSuccess extends StudentState {}
class GetViewsError extends StudentState {
  String err;
  GetViewsError(this.err);
}


class ResetViewsLoading extends StudentState {}
class ResetViewsSuccess extends StudentState {}
class ResetViewsError extends StudentState {
  String err;
  ResetViewsError(this.err);
}