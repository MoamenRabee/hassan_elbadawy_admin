import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/forms/form_file.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/widgets/delete_file_dialog.dart';

import '../../theme/theme.dart';
import '../../widgets/buttons.dart';
import 'cubit/states.dart';

class FileScreen extends StatelessWidget {
   FileScreen({super.key,required this.lessonId});

String lessonId;
  @override
  Widget build(BuildContext context) {
    LessonCubit cubit = LessonCubit.get(context);
    cubit.getFiles(lessonId: lessonId);

    return BlocConsumer<LessonCubit, LessonStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: cubit.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: MyColors.mainColor,
                    ),
                  )
                : cubit.allFiles.isEmpty
                    ? const Center(
                        child: Text("لا يوجد ملفات"),
                      )
                    : ListView.builder(
                        itemCount: cubit.allFiles.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.book),
                            title: Text(cubit.allFiles[index].fileName!),
                            trailing: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: CustomButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return deleteFileDialog(
                                              lessonId: lessonId,
                                              fileId: cubit
                                                  .allFiles[index].fileId!,
                                              context: context,
                                            );
                                          });
                                    },
                                    text: "حذف",
                                    width: 100,
                                    textColor: Colors.white,
                                    color: Colors.red,
                                  ),
                                ),
                          );
                        },
                      ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return FormFileScreen(
                        lessonId: lessonId,
                      );
                    });
              },
              icon: const Icon(Icons.add),
              label: const Text("اضافة ملف"),
            ),
          );
        });
  }
}
