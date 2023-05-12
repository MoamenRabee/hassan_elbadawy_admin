import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/cubit.dart';

import '../../routes/routes.dart';
import 'cubit/states.dart';

class ExamResultsScreen extends StatelessWidget {
  ExamResultsScreen({
    super.key,
    required this.classroomId,
    required this.examId,
    required this.langId,
    required this.lessonId,
  });

  String lessonId;
  String classroomId;
  String examId;
  String langId;

  @override
  Widget build(BuildContext context) {
    LessonCubit cubit = LessonCubit.get(context);

    cubit.getExamResult(examId: examId);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<LessonCubit, LessonStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  context.go(Uri(
                    path: Paths.LESSON_CONTENT,
                    queryParameters: {
                      "lessonId": lessonId,
                      "classroomId": classroomId,
                      "langId": langId,
                    },
                  ).toString());
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text("دراجات الاختبار"),
            ),
            body: cubit.isLoadingExam
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : cubit.allResultExam.isEmpty
                    ? const Center(
                        child: Text("لا يوجد دراجات"),
                      )
                    : ListView.builder(
                        itemCount: cubit.allResultExam.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.person),
                            title: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 300,
                                  ),
                                  child: Text(
                                      cubit.allResultExam[index].studentName!),
                                ),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 300,
                                  ),
                                  child: Text(
                                      cubit.allResultExam[index].studentPhone!),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${cubit.allResultExam[index].studentResult} من ${cubit.allResultExam[index].questionsCount}",
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          );
        },
      ),
    );
  }
}
