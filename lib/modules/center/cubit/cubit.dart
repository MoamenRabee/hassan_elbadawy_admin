import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/models/center_model.dart';
import 'package:hassan_elbadawy_admin/models/chat_model.dart';
import 'package:hassan_elbadawy_admin/modules/center/cubit/states.dart';

class CenterCubit extends Cubit<CenterStates> {
  CenterCubit() : super(CenterInitState());
  static CenterCubit get(BuildContext context) => BlocProvider.of(context);

  bool isLoading = false;
  bool isLoadingGetCenters = false;
  bool isLoadingAction = false;

  Future<void> addNewCenter({required String name}) async {
    isLoading = true;

    emit(AddCenterStateLoading());

    try {
      CenterModel centerModel = CenterModel(
        id: null,
        name: name,
      );

      DocumentReference<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection("Centers")
          .add(centerModel.toMap());
      result.update({"id": result.id});




      await getCenters();
      isLoading = false;
      emit(AddCenterStateSuccess());
    } catch (e) {
      log("$e");
      isLoading = false;
      emit(AddCenterStateErorr(e.toString()));
    }
  }

  List<CenterModel> allCenters = [];
  Future<void> getCenters() async {
    allCenters.clear();
    isLoadingGetCenters = true;
    emit(GetCenterStateLoading());
    try {
      QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection("Centers")
          .get();

      for(var element in result.docs){
        allCenters.add(CenterModel.fromJson(element.data()));
      }
      
      isLoadingGetCenters = false;
      emit(GetCenterStateSuccess());
    } catch (e) {
      log("$e");
      isLoadingGetCenters = false;
      emit(GetCenterStateErorr(e.toString()));
    }
  }


  Future<void> deleteCenter(String id)async{
    isLoadingAction = true;
    emit(DeleteCenterStateLoading());
    try{
      await FirebaseFirestore.instance.collection("Centers").doc(id).delete();
      isLoadingAction=false;
      await getCenters();
      emit(DeleteCenterStateSuccess());
    }catch(e){
      isLoadingAction=false;
      emit(DeleteCenterStateErorr(e.toString()));
    }
  }



}
