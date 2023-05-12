import 'dart:developer';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:download/download.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hassan_elbadawy_admin/functions/generateRandomString.dart';
import 'package:hassan_elbadawy_admin/functions/show_message.dart';
import 'package:hassan_elbadawy_admin/models/code_model.dart';
import 'package:hassan_elbadawy_admin/models/codes_group_model.dart';
import 'package:hassan_elbadawy_admin/modules/codes/cubit/states.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class CodesCubit extends Cubit<CodeStates> {
  CodesCubit() : super(CodeInitState());
  static CodesCubit get(BuildContext context) => BlocProvider.of(context);

  bool isLoading = false;
  bool isLoadingGetGroups = false;
  bool isLoadingAction = false;
  bool isFileDownloadLoading = false;

  int codesAddedDone = 0;

  Future<void> addNewCodesGroup({required String title}) async {
    isLoading = true;

    emit(AddGroupStateLoading());

    try {
      CodesGroupModel codesGroupModel = CodesGroupModel(
        id: null,
        title: title,
        dateTime: DateTime.now(),
        isPrinted: false,
      );

      DocumentReference<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection("CodesGroups")
          .add(codesGroupModel.toMap());
      result.update({"id": result.id});
      await getCodesGroup();
      isLoading = false;
      emit(AddGroupStateSuccess());
    } catch (e) {
      log("$e");
      isLoading = false;
      emit(AddGroupStateErorr(e.toString()));
    }
  }

  List<CodesGroupModel> allGroupNotPrinted = [];
  List<CodesGroupModel> allGroupPrinted = [];
  Future<void> getCodesGroup() async {
    isLoadingGetGroups = true;
    emit(GetGroupStateLoading());
    try {
      allGroupNotPrinted.clear();
      allGroupPrinted.clear();
      QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection("CodesGroups")
          .orderBy("dateTime")
          .get();

      for (var element in result.docs) {
        if (element.data()["isPrinted"] == true) {
          allGroupPrinted.add(CodesGroupModel.fromJson(element.data()));
        } else {
          allGroupNotPrinted.add(CodesGroupModel.fromJson(element.data()));
        }
      }

      isLoadingGetGroups = false;
      emit(GetGroupStateSuccess());
    } catch (e) {
      log("$e");
      isLoadingGetGroups = false;
      emit(GetGroupStateErorr(e.toString()));
    }
  }

  Future<void> toArchive(String id, bool isPrinted) async {
    isLoadingAction = true;
    emit(ToArchiveStateLoading());
    try {
      await FirebaseFirestore.instance
          .collection("CodesGroups")
          .doc(id)
          .update({"isPrinted": isPrinted});
      isLoadingAction = false;
      await getCodesGroup();
      emit(ToArchiveStateSuccess());
    } catch (e) {
      isLoadingAction = false;
      emit(ToArchiveStateErorr(e.toString()));
    }
  }

  Future<void> deleteGroup(String id) async {
    isLoadingAction = true;
    emit(DeleteStateLoading());
    try {
      await FirebaseFirestore.instance
          .collection("CodesGroups")
          .doc(id)
          .delete();
      isLoadingAction = false;
      await getCodesGroup();
      emit(DeleteStateSuccess());
    } catch (e) {
      isLoadingAction = false;
      emit(DeleteStateErorr(e.toString()));
    }
  }

  Future<void> addCodes({
    required BuildContext context,
    required String groupId,
    required int codesTotalCount,
    required int priceCodes,
  }) async {
    isLoadingAction = true;
    emit(AddCodesLoading());
    try {
      for (var i = 1; i <= codesTotalCount; i++) {
        String code = generateRandomString(10);

        CodeModel codesModel = CodeModel(
          groupId: groupId,
          code: code,
          isUsed: false,
          codePrice: priceCodes.toString(),
          usedBy: null,
          usedTime: null,
          usedByStudentName: null,
          lessonName: null,
          lessonId: null,
        );

        await FirebaseFirestore.instance
            .collection("Codes")
            .doc(code.toString())
            .set(codesModel.toMap())
            .then((value) {
          log(code);
          codesAddedDone++;
          // if done
          if (codesAddedDone >= codesTotalCount) {
            codesAddedDone = 0;
            codesTotalCount = 0;
            isLoadingAction = false;
            emit(AddCodesSuccess());
            log("done");
            getCodes(groupId: groupId);
            Navigator.pop(context);
          }

          emit(AddCodeOneSuccess());
        }).catchError((err) {
          log(err.toString());
        });
      }
    } catch (e) {
      log(e.toString());
      isLoadingAction = false;
      emit(AddCodesErorr(e.toString()));
    }
  }

  List<CodeModel> allCodes = [];
  void getCodes({required String groupId}) async {
    isLoading = true;
    emit(GetCodesLoading());
    try {
      allCodes.clear();
      QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection("Codes")
          .where("groupId", isEqualTo: groupId)
          .where("isUsed", isEqualTo: false)
          .limit(200)
          .get();

      allCodes = result.docs.map((e) => CodeModel.fromJson(e.data())).toList();

      isLoading = false;
      emit(GetCodesSuccess());
    } catch (e) {
      log("$e");
      isLoading = false;
      emit(GetCodesErorr(e.toString()));
    }
  }

  Future<void> deleteCode(String code, String groupId) async {
    isLoading = true;
    emit(DeleteCodeLoading());
    try {
      await FirebaseFirestore.instance.collection("Codes").doc(code).delete();
      isLoading = false;
      getCodes(groupId: groupId);
      emit(DeleteCodeSuccess());
    } catch (e) {
      isLoading = false;
      emit(DeleteCodeErorr(e.toString()));
    }
  }

  Future<void> downloadCodesAsExcelFile({
    required String groupId,
  }) async {
    try {
      if (isFileDownloadLoading == false) {
        showMessage(message: "جارى الأن استخراج البيانات");
        isFileDownloadLoading = true;
        emit(DownloadCodeLoading());
        int countRows = 0;
        List<CodeModel> allCodes = [];

        QuerySnapshot<Map<String, dynamic>> codes = await FirebaseFirestore
            .instance
            .collection('Codes')
            .where('isUsed', isEqualTo: false)
            .where('groupId', isEqualTo: groupId)
            .get();

        for (var element in codes.docs) {
          allCodes.add(CodeModel.fromJson(element.data()));
        }
        countRows = allCodes.length;
        final Workbook workbook = Workbook();
        final Worksheet sheet = workbook.worksheets[0];

        for (var i = 0; i < countRows; i++) {
          sheet.getRangeByName('A${i + 1}').setText('${allCodes[i].code}');
          sheet.getRangeByName('C${i + 1}').setText('${allCodes[i].codePrice}');
        }

        final List<int> bytes = workbook.saveAsStream();
        workbook.dispose();

        final rawData = Uint8List.fromList(bytes);

        final stream = Stream.fromIterable(rawData);
        download(stream, 'codes.xlsx');

        isFileDownloadLoading = false;
        emit(DownloadCodeSuccess());
      }
    } catch (e) {
      log(e.toString());
      isFileDownloadLoading = true;
      emit(DownloadCodeErorr(e.toString()));
    }
  }
}
