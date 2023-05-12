import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/widgets/delete_exam_dialog.dart';

import '../../functions/format_date.dart';
import '../../routes/routes.dart';
import '../../widgets/buttons.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'forms/form_exam.dart';

class ExamScreen extends StatelessWidget {
  ExamScreen({
    super.key,
    required this.lessonId,
    required this.classroomId,
    required this.langId,
  });

  String lessonId;
  String classroomId;
  String langId;
  @override
  Widget build(BuildContext context) {
    LessonCubit cubit = LessonCubit.get(context);

    cubit.getExams(lessonId: lessonId);

    return BlocConsumer<LessonCubit, LessonStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: cubit.isLoadingExam
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: cubit.allExams.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        context.go(Uri(path: Paths.QUSTIONS, queryParameters: {
                          "langID": langId,
                          "classroomID": classroomId,
                          "lessonId": lessonId,
                          "examId": cubit.allExams[index].examId,
                        }).toString());
                      },
                      leading: const Icon(Icons.book),
                      title: Text(cubit.allExams[index].examName!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: CustomButton(
                              onPressed: () {
                                cubit.publishExam(lessonId: lessonId);
                              },
                              text: "نشر",
                              textColor: Colors.white,
                              width: 100,
                              color: Colors.green,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: CustomButton(
                              onPressed: () {
                                context.go(Uri(
                                  path: Paths.EXAM_RESULTS,
                                  queryParameters: {
                                    "lessonId": lessonId,
                                    "classroomId": classroomId,
                                    "langId": langId,
                                    "examId": cubit.allExams[index].examId,
                                  },
                                ).toString());
                              },
                              text: "الدراجات",
                              textColor: Colors.white,
                              color: Colors.orange,
                              width: 100,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: CustomButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return FormExamScreen(
                                      lessonId: lessonId,
                                      action: "edit",
                                      examModel: cubit.allExams[index],
                                    );
                                  },
                                );
                              },
                              text: "تعديل",
                              textColor: Colors.white,
                              color: Colors.blue,
                              width: 100,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: CustomButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return deleteExamDialog(
                                        context: context,
                                        lessonId: lessonId,
                                        examId: cubit.allExams[index].examId!,
                                      );
                                    });
                              },
                              text: "حذف",
                              textColor: Colors.white,
                              color: Colors.red,
                              width: 100,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return FormExamScreen(
                      lessonId: lessonId,
                      action: "add",
                    );
                  });
            },
            icon: const Icon(Icons.add),
            label: const Text("اضافة امتحان"),
          ),
        );
      },
    );
  }
}
