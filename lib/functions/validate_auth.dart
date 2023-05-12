import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/functions/cache_helper.dart';
import 'package:hassan_elbadawy_admin/routes/routes.dart';

import '../widgets/not_logged_in_screen.dart';

extension IsAuth on Widget {
  Widget isLogin() {
    String? email = CacheHelper.getString(key: "admin");
    if (email == null || email.isEmpty) {
      return const NotLoggedInScreen();
    } else {
      // log("IsLoggedIn");
      return this;
    }
  }
}
