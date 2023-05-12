import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/modules/qustions/form_qustion_screen.dart';
import 'package:hassan_elbadawy_admin/modules/qustions/widgets/delete_question_dialog.dart';

import '../../routes/routes.dart';
import '../../widgets/buttons.dart';
import 'cubit/qustion_cubit.dart';

class QustionsScreen extends StatelessWidget {
  QustionsScreen({
    super.key,
    required this.classroomId,
    required this.langId,
    required this.lessonId,
    required this.examId,
  });

  String langId;
  String classroomId;
  String lessonId;
  String examId;

  @override
  Widget build(BuildContext context) {
    QustionCubit cubit = QustionCubit.get(context);

    cubit.getQuestions(examId: examId);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.go(Uri(path: Paths.LESSON_CONTENT, queryParameters: {
                "langId": langId,
                "classroomId": classroomId,
                "lessonId": lessonId,
              }).toString());
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("الآسئلة"),
        ),
        body: BlocConsumer<QustionCubit, QustionState>(
          listener: (context, state) {},
          builder: (context, state) {
            return cubit.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : cubit.allQuestions.isEmpty
                    ? const Center(
                        child: Text("لا يوجد آسئلة"),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "عدد الأسئلة : ${cubit.allQuestions.length}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: cubit.allQuestions.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title:
                                      Text(cubit.allQuestions[index].question!),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: CustomButton(
                                          onPressed: () {
                                            // log("$index");
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return FormQustionScreen(
                                                  examId: examId,
                                                  questionModel:
                                                      cubit.allQuestions[index],
                                                  action: "edit",
                                                );
                                              },
                                            );
                                          },
                                          text: "تعديل",
                                          width: 100,
                                          textColor: Colors.white,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: CustomButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return deleteQuestionDialog(
                                                    context: context,
                                                    examId: examId,
                                                    questionId: cubit
                                                        .allQuestions[index]
                                                        .questionId!,
                                                  );
                                                });
                                          },
                                          text: "حذف",
                                          width: 100,
                                          textColor: Colors.white,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return FormQustionScreen(
                    examId: examId,
                    action: "add",
                  );
                });
          },
          icon: const Icon(Icons.add),
          label: const Text("اضافة سؤال"),
        ),
      ),
    );
  }
}
