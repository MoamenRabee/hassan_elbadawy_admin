import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:hassan_elbadawy_admin/functions/functions.dart';
import 'package:hassan_elbadawy_admin/functions/generateMd5.dart';
import 'package:hassan_elbadawy_admin/models/student_model.dart';

import '../../../models/lesson_model.dart';
import '../../../models/views_video_model.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit() : super(StudentInitial());

  static StudentCubit get(BuildContext context) => BlocProvider.of(context);

  bool isLoading = false;
  bool isLoadingNew = false;
  bool isLoadingUpdate = false;
  bool isLoadingDelete = false;
  bool isSearching = false;
  bool isLoadingViews = false;
  List<StudentModel> searchedStudent = [];
  List<StudentModel> allStudents = [];

  void search({required String word}) {
    if (word == "" || word.isEmpty) {
      isSearching = false;
      emit(SearchInStudents());
    } else {}
    isSearching = true;
    emit(SearchInStudents());

    searchedStudent = allStudents
        .where((element) =>
            element.studentName!.startsWith(word) ||
            element.studentPhone!.startsWith(word))
        .toList();

    log(searchedStudent.toString());

    emit(SearchInStudents());
  }

  Future<void> getStudents() async {
    allStudents.clear();
    isLoading = true;
    emit(GetStudentsLoading());
    try {
      QuerySnapshot<Map<String, dynamic>> result =
          await FirebaseFirestore.instance.collection("Students").get();

      allStudents =
          result.docs.map((e) => StudentModel.fromJson(e.data())).toList();

      isLoading = false;
      emit(GetStudentsSuccess());
    } catch (e) {
      isLoading = false;
      emit(GetStudentsError(e.toString()));
    }
  }

  Future<void> updateStudent({
    required StudentModel student,
    required String name,
    required String fatherPhone,
    required String password,
  }) async {
    isLoadingUpdate = true;
    emit(UpdateStudentsLoading());
    try {
      StudentModel updatedStudent = StudentModel(
        studentName: name,
        studentPhone: student.studentPhone,
        fatherPhone: fatherPhone,
        classroomId: student.classroomId,
        langId: student.langId,
        studentPassword:
            password == "" ? student.studentPassword : generateMd5(password),
        deviceId: student.deviceId,
        centerId: student.centerId!,
        centerName: student.centerName!,
      );

      await FirebaseFirestore.instance
          .collection("Students")
          .doc(student.studentPhone)
          .update(updatedStudent.toMap());

      getStudents();

      isLoadingUpdate = false;
      emit(UpdateStudentsSuccess());
    } catch (e) {
      isLoadingUpdate = false;
      emit(UpdateStudentsError(e.toString()));
    }
  }

  Future<void> reNewStudent({
    required StudentModel student,
  }) async {
    isLoadingNew = true;
    emit(ReNewStudentsLoading());
    try {
      await FirebaseFirestore.instance
          .collection("Students")
          .doc(student.studentPhone)
          .update({
        "deviceId": "",
      });

      isLoadingNew = false;
      emit(ReNewStudentsSuccess());
    } catch (e) {
      isLoadingNew = false;
      emit(ReNewStudentsError(e.toString()));
    }
  }

  Future<void> deleteStudent({
    required StudentModel student,
  }) async {
    isLoadingDelete = true;
    emit(DeleteStudentsLoading());
    try {
      await FirebaseFirestore.instance
          .collection("Students")
          .doc(student.studentPhone)
          .delete();

      await decrementCount(field: "studentCount");

      getStudents();

      isLoadingDelete = false;
      emit(DeleteStudentsSuccess());
    } catch (e) {
      isLoadingDelete = false;
      emit(DeleteStudentsError(e.toString()));
    }
  }

  List<LessonModel> allLessons = [];
  List<ViewsVideoModel> views = [];
  void getViews({required StudentModel studentModel}) async {
    allLessons.clear();
    views.clear();
    isLoadingViews = true;
    emit(GetViewsLoading());
    try {
      var result = await FirebaseFirestore.instance
          .collection("Lessons")
          .where("classroomId", isEqualTo: studentModel.classroomId.toString())
          .get();

      allLessons =
          result.docs.map((e) => LessonModel.fromJson(e.data())).toList();

      var resultViews = await FirebaseFirestore.instance
          .collection("Views")
          .where("studentPhone", isEqualTo: studentModel.studentPhone)
          .get();

      views = resultViews.docs
          .map((e) => ViewsVideoModel.fromJson(e.data()))
          .toList();

      isLoadingViews = false;
      emit(GetViewsSuccess());
    } catch (e) {
      isLoadingViews = false;
      emit(GetViewsError(e.toString()));
    }
  }

  void resetViews(
      {required StudentModel studentModel,
      required ViewsVideoModel viewsVideoModel}) async {
    isLoadingViews = true;
    emit(GetViewsLoading());
    try {
      await FirebaseFirestore.instance
          .collection("Views")
          .doc(studentModel.studentPhone! + viewsVideoModel.videoId!)
          .get()
          .then((value) async {
        if (value.exists) {
          await FirebaseFirestore.instance
              .collection("Views")
              .doc(studentModel.studentPhone! + viewsVideoModel.videoId!)
              .update({
            "viewsCount": 0,
          });
        }
      });

      getViews(studentModel: studentModel);

      isLoadingViews = false;
      emit(GetViewsSuccess());
    } catch (e) {
      isLoadingViews = false;
      emit(GetViewsError(e.toString()));
    }
  }
  
}
