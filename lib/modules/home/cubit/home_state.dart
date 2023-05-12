part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}


class GetAnalysisLoading extends HomeState {}

class GetAnalysisSuccess extends HomeState {}

class GetAnalysisError extends HomeState {
  String err;
  GetAnalysisError(this.err);
}


class GetCommentsLoading extends HomeState {}

class GetCommentsSuccess extends HomeState {}

class GetCommentsError extends HomeState {
  String err;
  GetCommentsError(this.err);
}

class DeleteCommentLoading extends HomeState {}

class DeleteCommentSuccess extends HomeState {}

class DeleteCommentError extends HomeState {
  String err;
  DeleteCommentError(this.err);
}
