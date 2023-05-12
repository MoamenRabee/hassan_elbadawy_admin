import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/functions/fcm.dart';
import 'package:hassan_elbadawy_admin/functions/functions.dart';
import 'package:hassan_elbadawy_admin/models/lesson_model.dart';
import 'package:hassan_elbadawy_admin/modules/content/cubit/states.dart';

import '../../../functions/uploud_file.dart';

class ContentCubit extends Cubit<ContentStates> {
  ContentCubit() : super(ContentInitState());

  static ContentCubit get(BuildContext context) => BlocProvider.of(context);

  String? selectedLang;
  String? selectedClassroom;
  bool isLoading = false;
  bool isLoadingAction = false;
  bool isFree = false;
  Uint8List? selectedImage;
  String? imageExt;

  void selectLessonImage() async {
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

  void chageIsFree(bool val) {
    isFree = val;
    emit(ContentChangeIsFreeState());
  }

  void selectLang(String lang) {
    selectedLang = lang;
    selectedClassroom = null;
    emit(ContentChangeLangState());
  }

  void selectClassroom(String classroom) {
    selectedClassroom = classroom;
    emit(ContentChangeClassroomState());
  }

  List<LessonModel> allLessons = [];
  void getLessons({
    required String langID,
    required String classroomID,
  }) async {
    // log("get lessons");
    allLessons.clear();
    isLoading = true;
    emit(ContentGetLessonsLoadingState());
    try {
      var result = await FirebaseFirestore.instance
          .collection("Lessons")
          .orderBy("lessonOrderNumber")
          .where("langId", isEqualTo: langID)
          .where("classroomId", isEqualTo: classroomID)
          .get();
      allLessons =
          result.docs.map((e) => LessonModel.fromJson(e.data())).toList();

      isLoading = false;
      emit(ContentGetLessonsSuccessState());
    } catch (e) {
      isLoading = false;
      emit(ContentGetLessonsErrorState(e.toString()));
    }
  }

  Future<void> addNewLesson({
    required String langID,
    required String classroomID,
    required String name,
    required String price,
    required int orderNumber,
    required bool isFree,
  }) async {
    isLoadingAction = true;
    emit(ContentAddLessonLoadingState());
    try {
      LessonModel lessonModel = LessonModel(
        classroomId: classroomID,
        langId: langID,
        lessonId: null,
        lessonOrderNumber: orderNumber,
        lessonName: name,
        isFree: isFree,
        lessonImage :selectedImage == null
            ? ""
            : await uploadFile(
                refName: "LESSONS",
                bytes: selectedImage!,
                fileExtension: imageExt!),
        lessonPrice: price,
      );

      var result = await FirebaseFirestore.instance
          .collection("Lessons")
          .add(lessonModel.toMap());
      result.update({
        "lessonId": result.id,
      });

      await incrementCount(field: "lessonsCount");

      String topic = classroomID+langID;
      await sendFCM(topic: topic, title: "درس جديد", body: "تم اضافة درس $name");

      getLessons(langID: langID, classroomID: classroomID);

      selectedImage = null;

      isLoadingAction = false;
      emit(ContentAddLessonSuccessState());
    } catch (e) {
      isLoadingAction = false;
      emit(ContentAddLessonErrorState(e.toString()));
    }
  }

  Future<void> editLesson({
    required String name,
    required String price,
    required int orderNumber,
    required LessonModel oldLessonModel,
    required bool isFree,
  }) async {
    isLoadingAction = true;
    emit(ContentEditLessonLoadingState());
    try {
      LessonModel lessonModel = LessonModel(
        classroomId: oldLessonModel.classroomId,
        langId: oldLessonModel.langId,
        lessonId: oldLessonModel.lessonId,
        lessonOrderNumber: orderNumber,
        lessonName: name,
        lessonImage: selectedImage == null
            ? oldLessonModel.lessonImage
            : await uploadFile(
                refName: "LESSONS",
                bytes: selectedImage!,
                fileExtension: imageExt!),
        isFree: isFree,
        lessonPrice: price,
      );

      var result = await FirebaseFirestore.instance
          .collection("Lessons")
          .doc(oldLessonModel.lessonId)
          .update(lessonModel.toMap());

      getLessons(
        langID: oldLessonModel.langId!,
        classroomID: oldLessonModel.classroomId!,
      );

      selectedImage = null;

      isLoadingAction = false;
      emit(ContentEditLessonSuccessState());
    } catch (e) {
      isLoadingAction = false;
      emit(ContentEditLessonErrorState(e.toString()));
    }
  }

  void deleteLesson({
    required String lessonId,
    required String langID,
    required String classroomID,
  }) async {
    isLoadingAction = true;
    emit(ContentDeleteLessonLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection("Lessons")
          .doc(lessonId)
          .delete();
      await decrementCount(field: "lessonsCount");
      getLessons(langID: langID, classroomID: classroomID);
      isLoadingAction = false;
      emit(ContentDeleteLessonSuccessState());
    } catch (e) {
      isLoading = false;
      emit(ContentDeleteLessonErrorState(e.toString()));
    }
  }
}
