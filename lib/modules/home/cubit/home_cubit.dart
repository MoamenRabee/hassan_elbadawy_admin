import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/comment_model.dart';
import '../../../models/video_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  bool isLoadingComments = false;
  bool isLoadingAnalysis = false;

  int studentCount = 0;
  int viewsCount = 0;
  int lessonsCount = 0;
  int filesCount = 0;
  int examsCount = 0;

  void getAnalysis() async {
    isLoadingAnalysis = true;
    emit(GetAnalysisLoading());
    try {
      var result = await FirebaseFirestore.instance
          .collection("Analysis")
          .doc("Analysis")
          .get();

      if (result.exists) {
        studentCount = result.data()!["studentCount"];
        viewsCount = result.data()!["viewsCount"];
        lessonsCount = result.data()!["lessonsCount"];
        filesCount = result.data()!["filesCount"];
        examsCount = result.data()!["examsCount"];
      }

      isLoadingAnalysis = false;
      emit(GetAnalysisSuccess());
    } catch (e) {
      isLoadingAnalysis = false;
      emit(GetAnalysisError(e.toString()));
    }
  }

  List<CommentModel> allComments = [];
  void getComments() async {
    allComments.clear();
    isLoadingComments = true;
    emit(GetCommentsLoading());
    try {
      var result = await FirebaseFirestore.instance
          .collection("Comments")
          .orderBy("time", descending: true)
          .get();

      allComments =
          result.docs.map((e) => CommentModel.fromJson(e.data())).toList();

      isLoadingComments = false;
      emit(GetCommentsSuccess());
    } catch (e) {
      isLoadingComments = false;
      emit(GetCommentsError(e.toString()));
    }
  }

  void deleteComment(CommentModel commentModel) async {
    isLoadingComments = true;
    emit(DeleteCommentLoading());
    try {
      await FirebaseFirestore.instance
          .collection("Comments")
          .doc(commentModel.commentId)
          .delete();

      getComments();

      isLoadingComments = false;
      emit(DeleteCommentSuccess());
    } catch (e) {
      isLoadingComments = false;
      emit(DeleteCommentError(e.toString()));
    }
  }
}
