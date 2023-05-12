import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showMessage({
  required String message,
   Color? colorText,
   Color? color,
}) async {
 await Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: color??Colors.red,
        textColor: colorText??Colors.white,
        fontSize: 16.0,
        webBgColor: "linear-gradient(to right, #F44336, #F44336)"
    );
}