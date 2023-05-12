import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());

  static SettingCubit get(BuildContext context) => BlocProvider.of(context);

  bool isLoading = false;

  TextEditingController whatsAppController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();

  void getSettings() async {
    isLoading = true;
    emit(GetSettingsLoading());
    try {
      DocumentSnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection("Settings")
          .doc("Settings")
          .get();

      if (result.exists) {
        whatsAppController.text = result.data()!["whatsApp"];
        youtubeController.text = result.data()!["youtube"];
        facebookController.text = result.data()!["facebook"];
      }

      isLoading = false;
      emit(GetSettingsSuccess());
    } catch (e) {
      isLoading = false;
      emit(GetSettingsError());
    }
  }

  void updateSettings() async {
    isLoading = true;
    emit(UpdateSettingsLoading());
    try {
      await FirebaseFirestore.instance
          .collection("Settings")
          .doc("Settings")
          .update({
        "whatsApp": whatsAppController.text,
        "youtube": youtubeController.text,
        "facebook": facebookController.text,
      });

      getSettings();
      isLoading = false;
      emit(UpdateSettingsSuccess());
    } catch (e) {
      isLoading = false;
      emit(UpdateSettingsError());
    }
  }
}
