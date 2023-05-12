import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:hassan_elbadawy_admin/functions/uploud_file.dart';
import 'package:hassan_elbadawy_admin/models/exam_model.dart';

import '../../../functions/select_image.dart';

part 'qustion_state.dart';

class QustionCubit extends Cubit<QustionState> {
  QustionCubit() : super(QustionInitial());

  static QustionCubit get(BuildContext context) => BlocProvider.of(context);

  bool isLoadingAction = false;
  bool isLoading = false;
  int selectedAnswer = 0;
  Uint8List? selectedImage;
  String? imageExt;

  void selectAnswer(int val) {
    selectedAnswer = val;
    emit(SelectAnswerState());
  }

  void selectQuestionImage() async {
    final selectedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    selectedImage = selectedFile?.files.single.bytes;
    imageExt = selectedFile?.files.single.extension;
    if (selectedImage == null) {
      return;
    }
    emit(SelectImageState());
  }

  void removeImage() {
    selectedImage = null;
    emit(SelectImageState());
  }

  Future<void> addNewQuestions({
    required String examId,
    required String qustion,
    required String answer1,
    required String answer2,
    required String answer3,
    required String answer4,
    required int correctAnswer,
  }) async {
    isLoadingAction = true;
    emit(AddQustionLoading());
    try {
      QuestionModel questionModel = QuestionModel(
        questionId: null,
        examId: examId,
        question: qustion,
        questionImage: selectedImage == null
            ? ""
            : await uploadFile(
                refName: "QUESTIONS",
                bytes: selectedImage!,
                fileExtension: imageExt!),
        answers: [answer1, answer2, answer3, answer4],
        correctAnswer: correctAnswer,
      );

      var result = await FirebaseFirestore.instance
          .collection("Questions")
          .add(questionModel.toMap());
      result.update({"questionId": result.id});

      selectedAnswer = 0;
      selectedImage = null;

      getQuestions(examId: examId);

      isLoadingAction = false;
      log("Qusetion Added");
      emit(AddQustionSuccess());
    } catch (e) {
      isLoadingAction = false;
      emit(AddQustionError(e.toString()));
    }
  }

  Future<void> editQuestion({
    required QuestionModel questionModel,
    required String examId,
    required String qustion,
    required String answer1,
    required String answer2,
    required String answer3,
    required String answer4,
    required int correctAnswer,
  }) async {
    isLoadingAction = true;
    emit(EditQustionLoading());
    try {
      QuestionModel newquestionModel = QuestionModel(
        questionId: questionModel.questionId,
        examId: questionModel.examId,
        question: qustion,
        questionImage: selectedImage == null
            ? questionModel.questionImage
            : await uploadFile(
                refName: "QUESTIONS",
                bytes: selectedImage!,
                fileExtension: imageExt!),
        answers: [answer1, answer2, answer3, answer4],
        correctAnswer: correctAnswer,
      );

      await FirebaseFirestore.instance
          .collection("Questions")
          .doc(questionModel.questionId)
          .update(newquestionModel.toMap());

      selectedAnswer = 0;
      selectedImage = null;

      getQuestions(examId: examId);

      isLoadingAction = false;
      log("Qusetion Edited");
      emit(EditQustionSuccess());
    } catch (e) {
      isLoadingAction = false;
      emit(EditQustionError(e.toString()));
    }
  }

  List<QuestionModel> allQuestions = [];
  void getQuestions({
    required String examId,
  }) async {
    allQuestions.clear();
    isLoading = true;
    emit(GetQuestionsLoading());
    try {
      var result = await FirebaseFirestore.instance
          .collection("Questions")
          .where("examId", isEqualTo: examId)
          .get();

      allQuestions =
          result.docs.map((e) => QuestionModel.fromJson(e.data())).toList();

      isLoading = false;
      emit(GetQuestionsSuccess());
    } catch (e) {
      isLoading = false;
      emit(GetQuestionsError(e.toString()));
    }
  }

  void deleteExam({
    required String examId,
    required String questionId,
  }) async {
    isLoadingAction = true;
    emit(DeleteQustionLoading());

    try {
      await FirebaseFirestore.instance
          .collection("Questions")
          .doc(questionId)
          .delete();

      getQuestions(examId: examId);

      isLoadingAction = false;
      emit(DeleteQustionSuccess());
    } catch (e) {
      isLoadingAction = false;
      emit(DeleteQustionError(e.toString()));
    }
  }
}
