import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/functions/validate_auth.dart';
import 'package:hassan_elbadawy_admin/modules/content/form_lesson.dart';
import 'package:hassan_elbadawy_admin/modules/content/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/content/cubit/states.dart';
import 'package:hassan_elbadawy_admin/modules/content/widgets/delete_lesson_dialog.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';

import '../../routes/routes.dart';
import '../../theme/theme.dart';

class ContentScreen extends StatelessWidget {
  ContentScreen({
    super.key,
    required this.langID,
    required this.classroomID,
  });

  String langID;
  String classroomID;

  @override
  Widget build(BuildContext context) {
    ContentCubit cubit = ContentCubit.get(context);

    cubit.getLessons(
      langID: langID,
      classroomID: classroomID,
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<ContentCubit, ContentStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    context.go(Paths.CLASSROOMS);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                title: const Text("المحتوي"),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return FormLessonScreen(
                                langID: langID,
                                classroomID: classroomID,
                                action: "add",
                              );
                            });
                      },
                      text: "اضافة درس",
                      width: 200,
                      color: Colors.white,
                      textColor: MyColors.mainColor,
                    ),
                  ),
                ],
              ),
              body: cubit.isLoading || cubit.isLoadingAction
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: MyColors.mainColor,
                      ),
                    )
                  : cubit.allLessons.isEmpty
                      ? const Center(
                          child: Text("لا يوجد محتوي"),
                        )
                      : ListView.builder(
                          itemCount: cubit.allLessons.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                context.go(Uri(
                                  path: Paths.LESSON_CONTENT,
                                  queryParameters: {
                                    "lessonId":
                                        cubit.allLessons[index].lessonId,
                                    "classroomId":
                                        cubit.allLessons[index].classroomId,
                                    "langId": cubit.allLessons[index].langId,
                                  },
                                ).toString());
                              },
                              leading: const Icon(Icons.video_file),
                              title: Text(cubit.allLessons[index].lessonName!),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return FormLessonScreen(
                                              langID: langID,
                                              classroomID: classroomID,
                                              lessonModel:
                                                  cubit.allLessons[index],
                                              action: "edit",
                                            );
                                          });
                                    },
                                    text: "تعديل",
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    width: 100,
                                    height: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  CustomButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return deleteLessonDialog(
                                              context: context,
                                              lessonId: cubit
                                                  .allLessons[index].lessonId!,
                                              langID: langID,
                                              classroomID: classroomID,
                                            );
                                          });
                                    },
                                    text: "حذف",
                                    color: Colors.red,
                                    textColor: Colors.white,
                                    width: 100,
                                    height: 30,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            );
          }).isLogin(),
    );
  }
}
