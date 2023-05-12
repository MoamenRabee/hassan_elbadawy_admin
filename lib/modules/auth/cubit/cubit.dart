import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/functions/cache_helper.dart';
import 'package:hassan_elbadawy_admin/models/admin_model.dart';
import 'package:hassan_elbadawy_admin/modules/auth/cubit/states.dart';
import 'package:hassan_elbadawy_admin/routes/routes.dart';

import '../../../functions/show_message.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitState());

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  bool isLoading = false;

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading = true;
    emit(AuthLogInLoadingState());

    try {
      QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection("Admins")
          .where("email", isEqualTo: email.trim())
          .get();
      if (result.docs.isEmpty) {
        showMessage(message: "البريد الالكتروني غير صحيح");
      } else {
        AdminModel adminModel = AdminModel.fromJson(result.docs.first.data());
        if (adminModel.password != password) {
          showMessage(message: "كلمة المرور غير صحيحة");
        } else {
          CacheHelper.setString(key: "admin", value: email);
          context.go(Paths.HOME);
        }
      }

      isLoading = false;
      emit(AuthLogInSuccessState());
    } catch (e) {
      isLoading = false;
      log(e.toString());
      emit(AuthLogInErrorState(e.toString()));
    }
  }

  void logOut({required BuildContext context}) {
    CacheHelper.removeKey(key: "admin");
    context.go(Paths.LOGIN);
  }
}
