import 'package:flutter/material.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/qustions/cubit/qustion_cubit.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';

AlertDialog deleteQuestionDialog({
  required BuildContext context,
  required String questionId,
  required String examId,
}) =>
    AlertDialog(
      content: const Text("هل انت متآكد من عملية الحذف ؟"),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        CustomButton(
          onPressed: () {
            Navigator.pop(context);
            QustionCubit.get(context).deleteExam(questionId: questionId, examId: examId);
          },
          text: "نعم",
          color: Colors.red,
          width: 100,
          height: 30,
          textColor: Colors.white,
        ),
      ],
    );
