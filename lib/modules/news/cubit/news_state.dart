part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}


class SelectImageState extends NewsState {}

class GetNewsLoading extends NewsState {}
class GetNewsSuccess extends NewsState {}
class GetNewsError extends NewsState {}

class AddNewsLoading extends NewsState {}
class AddNewsSuccess extends NewsState {}
class AddNewsError extends NewsState {}

class EditNewsLoading extends NewsState {}
class EditNewsSuccess extends NewsState {}
class EditNewsError extends NewsState {}

class DeleteNewsLoading extends NewsState {}
class DeleteNewsSuccess extends NewsState {}
class DeleteNewsError extends NewsState {}