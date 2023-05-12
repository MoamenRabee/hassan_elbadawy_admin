import 'package:flutter/material.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';

AlertDialog deleteExamDialog({
  required BuildContext context,
  required String lessonId,
  required String examId,
}) =>
    AlertDialog(
      content: const Text("هل انت متآكد من عملية الحذف ؟"),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        CustomButton(
          onPressed: () {
            Navigator.pop(context);
            LessonCubit.get(context).deleteExam(lessonId: lessonId, examId: examId);
          },
          text: "نعم",
          color: Colors.red,
          width: 100,
          height: 30,
          textColor: Colors.white,
        ),
      ],
    );
