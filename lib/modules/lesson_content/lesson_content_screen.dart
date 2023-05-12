import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/functions/validate_auth.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/exam_screen.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/file_screen.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/video_screen.dart';

import '../../routes/routes.dart';
import '../../theme/theme.dart';

class LessonContentScreen extends StatelessWidget {
  LessonContentScreen({
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.go(Uri(path: Paths.CONTENT, queryParameters: {
                  "langID": langId,
                  "classroomID": classroomId,
                }).toString());
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text("محتوي الدرس"),
            bottom: const TabBar(
              indicatorColor: MyColors.blackColor,
              tabs: [
                Tab(
                  child: Text("الفيديوهات"),
                ),
                Tab(
                  child: Text("الاختبارات"),
                ),
                Tab(
                  child: Text("الملفات"),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              VideoScreen(
                lessonId: lessonId,
              ),
              ExamScreen(lessonId: lessonId,classroomId: classroomId,langId: langId),
              FileScreen(lessonId: lessonId,),
            ],
          ),
        ),
      ),
    ).isLogin();
  }
}
