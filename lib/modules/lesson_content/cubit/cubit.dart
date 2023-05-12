import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/functions/uploud_file.dart';
import 'package:hassan_elbadawy_admin/models/exam_model.dart';
import 'package:hassan_elbadawy_admin/models/file_model.dart';
import 'package:hassan_elbadawy_admin/models/lesson_model.dart';
import 'package:hassan_elbadawy_admin/models/results_exam_model.dart';
import 'package:hassan_elbadawy_admin/models/video_model.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/states.dart';

import '../../../functions/fcm.dart';
import '../../../functions/functions.dart';

class LessonCubit extends Cubit<LessonStates> {
  LessonCubit() : super(LessonInitState());

  static LessonCubit get(BuildContext context) => BlocProvider.of(context);

  bool isActionLoading = false;
  bool isLoading = false;

  bool isLoadingExam = false;
  bool isLoadingActionExam = false;
  Uint8List? selectedPDF;

  void selectPDF() async {
    final selectedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    selectedPDF = selectedFile?.files.single.bytes;
    if (selectedPDF == null) {
      return;
    }

    emit(SelectPDFState());
  }

  void removePDF() async {
    selectedPDF = null;
    emit(SelectPDFState());
  }

  Future<void> addNewVideo({
    required String lessonId,
    required String videoName,
    required String videoDesc,
    required String videoURL,
    required String viewsCount,
    required String videoOrderNumber,
  }) async {
    isActionLoading = true;
    emit(LessonAddVideoLoadingState());
    try {
      VideoModel videoModel = VideoModel(
        lessonId: lessonId,
        videoId: null,
        videoOrderNumber: int.parse(videoOrderNumber),
        videoName: videoName,
        videoDesc: videoDesc,
        videoURL: videoURL,
        viewsCount: int.parse(viewsCount),
      );

      var result = await FirebaseFirestore.instance
          .collection("Videos")
          .add(videoModel.toMap());
      await result.update({"videoId": result.id});

      var resultLesson = await FirebaseFirestore.instance
          .collection("Lessons")
          .where("lessonId", isEqualTo: lessonId)
          .limit(1)
          .get();
      LessonModel resultLessonModel =
          LessonModel.fromJson(resultLesson.docs.first.data());

      String topic = resultLessonModel.classroomId! + resultLessonModel.langId!;
      await sendFCM(
          topic: topic,
          title: resultLessonModel.lessonName!,
          body: "تم اضافة فيديو");

      getVideos(lessonId: lessonId);
      isActionLoading = false;
      emit(LessonAddVideoSuccessState());
    } catch (e) {
      isActionLoading = false;
      emit(LessonAddVideoErrorState(e.toString()));
    }
  }

  List<VideoModel> allVideos = [];
  Future<void> getVideos({
    required String lessonId,
  }) async {
    allVideos.clear();
    isLoading = true;
    emit(LessonGetVideosLoadingState());
    try {
      QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection("Videos")
          .where("lessonId", isEqualTo: lessonId)
          .orderBy("videoOrderNumber")
          .get();

      allVideos =
          result.docs.map((e) => VideoModel.fromJson(e.data())).toList();
      isLoading = false;
      emit(LessonGetVideosSuccessState());
    } catch (e) {
      isLoading = false;
      emit(LessonGetVideosErrorState(e.toString()));
    }
  }

  void deleteVideo({
    required String lessonId,
    required String videoId,
  }) async {
    isActionLoading = true;
    emit(LessonDeleteVideoLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection("Videos")
          .doc(videoId)
          .delete();
      getVideos(lessonId: lessonId);
      isActionLoading = false;
      emit(LessonDeleteVideoSuccessState());
    } catch (e) {
      isActionLoading = false;
      emit(LessonDeleteVideoErrorState(e.toString()));
    }
  }

  Future<void> updateVideo({
    required String lessonId,
    required String videoName,
    required String videoId,
    required String videoDesc,
    required String videoURL,
    required String viewsCount,
    required String videoOrderNumber,
  }) async {
    isActionLoading = true;
    emit(LessonEditVideoLoadingState());
    try {
      VideoModel videoModel = VideoModel(
        lessonId: lessonId,
        videoId: videoId,
        videoOrderNumber: int.parse(videoOrderNumber),
        videoName: videoName,
        videoDesc: videoDesc,
        videoURL: videoURL,
        viewsCount: int.parse(viewsCount),
      );

      await FirebaseFirestore.instance
          .collection("Videos")
          .doc(videoId)
          .update(videoModel.toMap());
      getVideos(lessonId: lessonId);
      isActionLoading = false;
      emit(LessonEditVideoSuccessState());
    } catch (e) {
      isActionLoading = false;
      emit(LessonEditVideoErrorState(e.toString()));
    }
  }

  Future<void> addNewExam({
    required String examName,
    required String lessonId,
  }) async {
    isLoadingActionExam = true;
    emit(AddNewExamLoading());
    try {
      ExamModel examModel =
          ExamModel(lessonId: lessonId, examId: null, examName: examName);

      var result = await FirebaseFirestore.instance
          .collection("Exams")
          .add(examModel.toMap());
      await result.update({
        "examId": result.id,
      });

      await incrementCount(field: "examsCount");

      getExams(lessonId: lessonId);

      emit(AddNewExamSuccess());
    } catch (e) {
      isLoadingActionExam = false;
      emit(AddNewExamError(e.toString()));
    }
  }

  void publishExam({required String lessonId}) async {
    isLoadingExam = true;
    emit(AddNewExamLoading());
    try {
      var resultLesson = await FirebaseFirestore.instance
          .collection("Lessons")
          .where("lessonId", isEqualTo: lessonId)
          .limit(1)
          .get();
      LessonModel resultLessonModel =
          LessonModel.fromJson(resultLesson.docs.first.data());

      String topic = resultLessonModel.classroomId! + resultLessonModel.langId!;
      await sendFCM(
          topic: topic,
          title: resultLessonModel.lessonName!,
          body: "تم اضافة اختبار");

      isLoadingExam = false;
      emit(AddNewExamSuccess());
    } catch (e) {
      log(e.toString());
      isLoadingExam = false;
      emit(AddNewExamError(e.toString()));
    }
  }

  List<ExamModel> allExams = [];
  Future<void> getExams({
    required String lessonId,
  }) async {
    allExams.clear();
    isLoadingExam = true;
    emit(GetExamsLoading());
    try {
      QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection("Exams")
          .where("lessonId", isEqualTo: lessonId)
          .get();

      allExams = result.docs.map((e) => ExamModel.fromJson(e.data())).toList();
      isLoadingExam = false;
      emit(GetExamsSuccess());
    } catch (e) {
      isLoadingExam = false;
      emit(GetExamsError(e.toString()));
    }
  }

  void deleteExam({
    required String lessonId,
    required String examId,
  }) async {
    isLoadingActionExam = true;
    emit(DeleteExamLoading());
    try {
      await FirebaseFirestore.instance.collection("Exams").doc(examId).delete();
      await decrementCount(field: "examsCount");
      getExams(lessonId: lessonId);
      isLoadingActionExam = false;
      emit(DeleteExamSuccess());
    } catch (e) {
      isLoadingActionExam = false;
      emit(DeleteExamError(e.toString()));
    }
  }

  Future<void> updateExam({
    required String lessonId,
    required String examId,
    required String examName,
  }) async {
    isLoadingActionExam = true;
    emit(UpdateExamLoading());
    try {
      ExamModel examModel = ExamModel(
        lessonId: lessonId,
        examId: examId,
        examName: examName,
      );

      await FirebaseFirestore.instance
          .collection("Exams")
          .doc(examId)
          .update(examModel.toMap());
      getExams(lessonId: lessonId);

      isLoadingActionExam = false;

      emit(UpdateExamSuccess());
    } catch (e) {
      isLoadingActionExam = false;
      emit(UpdateExamError(e.toString()));
    }
  }

  Future<void> addNewFile({
    required String lessonId,
    required String fileName,
  }) async {
    isActionLoading = true;
    emit(AddNewFileLoading());
    try {
      String urlFile = await uploadFile(
          refName: "PDF", bytes: selectedPDF!, fileExtension: 'pdf');

      FileModel fileModel = FileModel(
        lessonId: lessonId,
        fileId: null,
        fileName: fileName,
        fileURL: urlFile,
      );

      var result = await FirebaseFirestore.instance
          .collection("Files")
          .add(fileModel.toMap());

      await result.update({"fileId": result.id});

      await incrementCount(field: "filesCount");

      var resultLesson = await FirebaseFirestore.instance
          .collection("Lessons")
          .where("lessonId", isEqualTo: lessonId)
          .limit(1)
          .get();
      LessonModel resultLessonModel =
          LessonModel.fromJson(resultLesson.docs.first.data());

      String topic = resultLessonModel.classroomId! + resultLessonModel.langId!;
      await sendFCM(
          topic: topic,
          title: resultLessonModel.lessonName!,
          body: "تم اضافة ملف");

      await getFiles(lessonId: lessonId);
      selectedPDF = null;

      isActionLoading = false;
      emit(AddNewFileSuccess());
    } catch (e) {
      isActionLoading = false;
      emit(AddNewFileError(e.toString()));
    }
  }

  List<FileModel> allFiles = [];
  Future<void> getFiles({
    required String lessonId,
  }) async {
    allFiles.clear();
    isLoading = true;
    emit(GetFilesLoading());
    try {
      QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection("Files")
          .where("lessonId", isEqualTo: lessonId)
          .get();

      allFiles = result.docs.map((e) => FileModel.fromJson(e.data())).toList();
      isLoading = false;
      emit(GetExamsSuccess());
    } catch (e) {
      isLoading = false;
      emit(GetFilesError(e.toString()));
    }
  }

  void deleteFile({
    required String lessonId,
    required String fileId,
  }) async {
    isActionLoading = true;
    emit(DeleteFileLoading());
    try {
      await FirebaseFirestore.instance.collection("Files").doc(fileId).delete();
      await decrementCount(field: "filesCount");
      getFiles(lessonId: lessonId);

      isActionLoading = false;
      emit(DeleteFileSuccess());
    } catch (e) {
      isActionLoading = false;
      emit(DeleteExamError(e.toString()));
    }
  }

  List<ResultsExamModel> allResultExam = [];
  Future<void> getExamResult({
    required String examId,
  }) async {
    allResultExam.clear();
    isLoadingExam = true;
    emit(GetExamsResultsoading());
    try {
      QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection("ExamResults")
          .where("examId", isEqualTo: examId)
          .get();

      allResultExam =
          result.docs.map((e) => ResultsExamModel.fromJson(e.data())).toList();
      isLoadingExam = false;
      emit(GetExamsResultsSuccess());
    } catch (e) {
      isLoadingExam = false;
      emit(GetExamsResultsError(e.toString()));
    }
  }
}
