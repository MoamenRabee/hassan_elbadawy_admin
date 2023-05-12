import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:hassan_elbadawy_admin/models/lesson_model.dart';
import 'package:hassan_elbadawy_admin/models/monthly_system_model.dart';
import 'package:hassan_elbadawy_admin/routes/routes.dart';

part 'state.dart';

class MonthlyCubit extends Cubit<MonthlyState> {
  MonthlyCubit() : super(MonthlyInitial());

  static MonthlyCubit get(BuildContext context) => BlocProvider.of(context);

  bool isLoadingAction = false;
  bool isLoading = false;
  bool isLoadingLessons = false;
  bool addLessonLoading = false;

  String? selectedLang;
  String? selectedClassroom;

  void selectLang(String lang) {
    selectedLang = lang;
    selectedClassroom = null;
    emit(ContentChangeLangState());
  }

  void selectClassroom(String classroom) {
    selectedClassroom = classroom;
    emit(ContentChangeClassroomState());
  }

  Future<void> addMonth({
    required String langID,
    required String classroomID,
    required String name,
    required String price,
    required int orderNumber,
  }) async {
    isLoadingAction = true;
    emit(AddMonthLoading());
    try {
      MonthlySystemModel monthlySystemModel = MonthlySystemModel(
        classroomId: classroomID,
        langId: langID,
        systemId: null,
        systemOrderNumber: orderNumber,
        systemName: name,
        systemPrice: price,
        lessons: [],
      );

      var result = await FirebaseFirestore.instance
          .collection("MonthlySystems")
          .add(monthlySystemModel.toMap());
      await result.update({
        "systemId": result.id,
      });

      isLoadingAction = false;
      getMonthlySystems();
      emit(AddMonthSuccess());
    } catch (e) {
      isLoadingAction = false;
      emit(AddMonthError(e.toString()));
    }
  }

  Future<void> updateMonth({
    required String name,
    required String price,
    required int orderNumber,
    required MonthlySystemModel monthlySystemModel,
  }) async {
    isLoadingAction = true;
    emit(UpdateMonthLoading());
    try {
      MonthlySystemModel newUpdateMonthly = MonthlySystemModel(
        classroomId: monthlySystemModel.classroomId!,
        langId: monthlySystemModel.langId!,
        systemId: monthlySystemModel.systemId!,
        systemOrderNumber: orderNumber,
        systemName: name,
        systemPrice: price,
        lessons: monthlySystemModel.lessons,
      );

      await FirebaseFirestore.instance
          .collection("MonthlySystems")
          .doc(monthlySystemModel.systemId!)
          .update(newUpdateMonthly.toMap());

      isLoadingAction = false;
      getMonthlySystems();
      emit(UpdateMonthSuccess());
    } catch (e) {
      isLoadingAction = false;
      emit(UpdateMonthError(e.toString()));
    }
  }

  List<MonthlySystemModel> allMonthlySystems = [];
  void getMonthlySystems() async {
    allMonthlySystems.clear();
    isLoading = true;
    emit(GetMonthLoading());
    try {
      var result = await FirebaseFirestore.instance
          .collection("MonthlySystems")
          .orderBy("systemOrderNumber")
          .get();

      for (var element in result.docs) {
        allMonthlySystems.add(MonthlySystemModel.fromJson(element.data()));
      }

      isLoading = false;
      emit(GetMonthSuccess());
    } catch (e) {
      isLoading = false;
      emit(GetMonthError(e.toString()));
    }
  }

  Future<void> deleteMonth(String id) async {
    isLoadingAction = true;
    emit(DeleteMonthLoading());
    try {
      await FirebaseFirestore.instance
          .collection("MonthlySystems")
          .doc(id)
          .delete();
      isLoadingAction = false;
      getMonthlySystems();
      emit(DeleteMonthSuccess());
    } catch (e) {
      isLoadingAction = false;
      emit(DeleteMonthError(e.toString()));
    }
  }

  MonthlySystemModel? monthlySystemModel;
  List<LessonModel> allLessons = [];
  Future<void> getLessonsInMonthlySystems({
    required String systemId,
    required BuildContext context,
  }) async {
    monthlySystemModel = null;
    allLessons.clear();
    isLoading = true;
    emit(GetLessonsInMonthLoading());
    try {
      await FirebaseFirestore.instance
          .collection("MonthlySystems")
          .doc(systemId)
          .get()
          .then((monthlySystem) async {
        if (monthlySystem.exists) {
          monthlySystemModel =
              MonthlySystemModel.fromJson(monthlySystem.data()!);
          var result = await FirebaseFirestore.instance
              .collection("Lessons")
              .where("classroomId", isEqualTo: monthlySystemModel!.classroomId)
              .where("langId", isEqualTo: monthlySystemModel!.langId)
              .orderBy("lessonOrderNumber")
              .get();
          allLessons =
              result.docs.map((e) => LessonModel.fromJson(e.data())).toList();
        } else {
          context.go(Paths.HOME);
        }
      });

      isLoading = false;
      emit(GetLessonsInMonthSuccess());
    } catch (e) {
      isLoading = false;
      emit(GetLessonsInMonthError(e.toString()));
    }
  }

  Future<void> addLessonFromMonthlySystem({
    required LessonModel lessonModel,
    required String monthlySystemId,
    required BuildContext context,
  }) async {
    addLessonLoading = true;
    emit(LessonInMonthLoading());

    try {
      var result = await FirebaseFirestore.instance
          .collection("MonthlySystems")
          .doc(monthlySystemId)
          .get();

      List<dynamic> lessons = result.data()!["lessons"];
      lessons.add(lessonModel.lessonId!);

      await FirebaseFirestore.instance
          .collection("MonthlySystems")
          .doc(monthlySystemId)
          .update({
        "lessons": lessons,
      }).then((value) async {
        addLessonLoading = false;
        emit(LessonInMonthSuccess());

        await getLessonsInMonthlySystems(
          systemId: monthlySystemId,
          context: context,
        );
      }).catchError((err){
        print(err.toString());
      });
    } catch (e) {
      print(e);
      addLessonLoading = false;
      emit(LessonInMonthError(e.toString()));
    }
  }

  Future<void> removeLessonFromMonthlySystem({
    required LessonModel lessonModel,
    required String monthlySystemId,
    required BuildContext context,
  }) async {
    addLessonLoading = true;
    emit(LessonInMonthLoading());

    try {
      var result = await FirebaseFirestore.instance
          .collection("MonthlySystems")
          .doc(monthlySystemId)
          .get();

      List<dynamic> lessons = result.data()!["lessons"];
      lessons.remove(lessonModel.lessonId!);
      await FirebaseFirestore.instance
          .collection("MonthlySystems")
          .doc(monthlySystemId)
          .update({
        "lessons": lessons,
      }).then((value) async {
        addLessonLoading = false;
        emit(LessonInMonthSuccess());

        await getLessonsInMonthlySystems(
          systemId: monthlySystemId,
          context: context,
        );
      }).catchError((err){
        print(err.toString());
      });
    } catch (e) {
      print(e);
      addLessonLoading = false;
      emit(LessonInMonthError(e.toString()));
    }
  }
}
