import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/student_model.dart';
import 'cubit/student_cubit.dart';

class StudentViews extends StatelessWidget {
  StudentViews({super.key, required this.studentModel});

  StudentModel studentModel;

  @override
  Widget build(BuildContext context) {
    StudentCubit cubit = StudentCubit.get(context);
    cubit.getViews(studentModel: studentModel);
    return BlocConsumer<StudentCubit, StudentState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 700,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.all(20),
                      child: cubit.isLoadingViews
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : cubit.views.isEmpty
                              ? const Center(
                                  child: Text("لا يوجد مشاهدات"),
                                )
                              : ListView.builder(
                                  itemCount: cubit.views.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Row(
                                        children: [
                                          Expanded(
                                              child: Text(cubit.allLessons
                                                  .where((element) =>
                                                      element.lessonId ==
                                                      cubit.views[index]
                                                          .lessonId)
                                                  .first
                                                  .lessonName!)),
                                          Expanded(
                                              child: Text(cubit
                                                  .views[index].videoName!)),
                                          Expanded(
                                              child: Text(cubit
                                                  .views[index].viewsCount
                                                  .toString())),
                                          IconButton(
                                            onPressed: () {
                                              cubit.resetViews(
                                                studentModel: studentModel,
                                                viewsVideoModel:
                                                    cubit.views[index],
                                              );
                                            },
                                            icon: const Icon(Icons.refresh),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
