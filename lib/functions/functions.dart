import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hassan_elbadawy_admin/models/classrooms_model.dart';

Future<void> incrementCount({required String field}) async {
  try {
    var last = await FirebaseFirestore.instance
        .collection("Analysis")
        .doc("Analysis")
        .get();
    int lastCount = last.data()![field];
    await FirebaseFirestore.instance
        .collection("Analysis")
        .doc("Analysis")
        .update({field: lastCount + 1});
  } catch (e) {
    log(e.toString());
  }
}

Future<void> decrementCount({required String field}) async {
  try {
    var last = await FirebaseFirestore.instance
        .collection("Analysis")
        .doc("Analysis")
        .get();
    int lastCount = last.data()![field];
    await FirebaseFirestore.instance
        .collection("Analysis")
        .doc("Analysis")
        .update({field: lastCount - 1});
  } catch (e) {
    log(e.toString());
  }
}

String getClassroomName(int classroomId) {
  String classroomName = ClassroomModel.classroomsAR
      .where((element) => element.id == classroomId)
      .first
      .name;
  return classroomName;
}

String getLangName(String langId) {
  String langName = ClassroomModel.allClassrooms
      .where((element) => element.id == langId)
      .first
      .name;
  return langName;
}
