import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/states.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/forms/form_video.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/widgets/delete_video_dialog.dart';

import '../../functions/format_date.dart';
import '../../theme/theme.dart';
import '../../widgets/buttons.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({super.key, required this.lessonId});
  String lessonId;

  @override
  Widget build(BuildContext context) {
    LessonCubit cubit = LessonCubit.get(context);
    cubit.getVideos(lessonId: lessonId);

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
                : cubit.allVideos.isEmpty
                    ? const Center(
                        child: Text("لا يوجد فيديوهات"),
                      )
                    : ListView.builder(
                        itemCount: cubit.allVideos.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.book),
                            title: Text(cubit.allVideos[index].videoName!),
                            subtitle: Text(cubit.allVideos[index].videoDesc!),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: CustomButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return FormVideoScreen(
                                              lessonId: lessonId,
                                              videoModel:
                                                  cubit.allVideos[index],
                                              action: "edit",
                                            );
                                          });
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
                                            return deleteVideoDialog(
                                              lessonId: lessonId,
                                              videoId: cubit
                                                  .allVideos[index].videoId!,
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
                      return FormVideoScreen(
                        lessonId: lessonId,
                        action: "add",
                      );
                    });
              },
              icon: const Icon(Icons.add),
              label: const Text("اضافة فيديو"),
            ),
          );
        });
  }
}
