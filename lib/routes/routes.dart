import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/modules/auth/login_screen.dart';
import 'package:hassan_elbadawy_admin/modules/codes/all_codes_screen.dart';
import 'package:hassan_elbadawy_admin/modules/codes/codes_screen.dart';
import 'package:hassan_elbadawy_admin/modules/content/classrooms_screen.dart';
import 'package:hassan_elbadawy_admin/modules/content/content_screen.dart';
import 'package:hassan_elbadawy_admin/modules/layout/LayoutScreen.dart';
import 'package:hassan_elbadawy_admin/modules/layout/screen_not_found.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/exam_results.dart';
import 'package:hassan_elbadawy_admin/modules/monthly/monthly_content_screen.dart';
import 'package:hassan_elbadawy_admin/modules/monthly/monthly_screen.dart';
import 'package:hassan_elbadawy_admin/modules/news/news_screen.dart';
import 'package:hassan_elbadawy_admin/modules/qustions/qustions_sceen.dart';
import 'package:hassan_elbadawy_admin/modules/settings/settings_screen.dart';
import 'package:hassan_elbadawy_admin/modules/students/students_screen.dart';

import '../modules/center/center_screen.dart';
import '../modules/lesson_content/lesson_content_screen.dart';

class Paths {
  static String HOME = "/";
  static String CODES = "/codes";
  static String LOGIN = "/login";
  static String CENTERS = "/centers";
  static String CLASSROOMS = "/classrooms";
  static String CONTENT = "/content";
  static String LESSON_CONTENT = "/lesson-content";
  static String ALL_CODES = "/all-codes";
  static String STUDENTS = "/students";
  static String QUSTIONS = "/qustions";
  static String SETTINGS = "/settings";
  static String MONTHLY = "/monthly";
  static String MONTHLY_CONTENT = "/monthly-content";
  static String EXAM_RESULTS = "/exam-results";
  static String NEWS = "/news";
}

class Routes {
  static final router = GoRouter(
    initialLocation: Paths.LOGIN,
    routes: [
      GoRoute(
        path: Paths.HOME,
        builder: (context, state) => LayoutScreen(),
      ),
      GoRoute(
        path: Paths.LOGIN,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: Paths.CODES,
        builder: (context, state) => CodesScreen(),
      ),
      GoRoute(
        path: Paths.CENTERS,
        builder: (context, state) => CentersScreen(),
      ),
      GoRoute(
        path: Paths.CLASSROOMS,
        builder: (context, state) => ClassroomsScreen(),
      ),
      GoRoute(
        path: Paths.SETTINGS,
        builder: (context, state) => SettingsScreen(),
      ),
      GoRoute(
        path: Paths.MONTHLY,
        builder: (context, state) => MonthlyScreen(),
      ),
      GoRoute(
        path: Paths.NEWS,
        builder: (context, state) => NewsScreen(),
      ),
      GoRoute(
        path: Paths.MONTHLY_CONTENT,
        builder: (context, state) {
          if (state.queryParams["monthlySystemId"] == null) {
            return const NotFoundScreen();
          }
          return MonthlyContentScreen(
            monthlySystemId: state.queryParams["monthlySystemId"]!,
          );
        },
      ),
      GoRoute(
        path: Paths.CONTENT,
        builder: (context, state) {
          if (state.queryParams["langID"] == null ||
              state.queryParams["classroomID"] == null) {
            return const NotFoundScreen();
          }
          return ContentScreen(
            langID: state.queryParams["langID"]!,
            classroomID: state.queryParams["classroomID"]!,
          );
        },
      ),
      GoRoute(
        path: Paths.LESSON_CONTENT,
        builder: (context, state) {
          if (state.queryParams["lessonId"] == null ||
              state.queryParams["classroomId"] == null ||
              state.queryParams["langId"] == null) {
            return const NotFoundScreen();
          }
          return LessonContentScreen(
            lessonId: state.queryParams["lessonId"]!,
            classroomId: state.queryParams["classroomId"]!,
            langId: state.queryParams["langId"]!,
          );
        },
      ),
      GoRoute(
        path: Paths.EXAM_RESULTS,
        builder: (context, state) {
          if (state.queryParams["lessonId"] == null ||
              state.queryParams["classroomId"] == null ||
              state.queryParams["langId"] == null ||
              state.queryParams["examId"] == null) {
            return const NotFoundScreen();
          }
          return ExamResultsScreen(
            lessonId: state.queryParams["lessonId"]!,
            classroomId: state.queryParams["classroomId"]!,
            langId: state.queryParams["langId"]!,
            examId: state.queryParams["examId"]!,
          );
        },
      ),
      GoRoute(
        path: Paths.ALL_CODES,
        builder: (context, state) {
          if (state.queryParams["groupId"] == null) {
            return const NotFoundScreen();
          }
          return AllCodesScreen(
            groupId: state.queryParams["groupId"]!,
          );
        },
      ),
      GoRoute(
        path: Paths.STUDENTS,
        builder: (context, state) {
          return StudentsScreen();
        },
      ),
      GoRoute(
        path: Paths.QUSTIONS,
        builder: (context, state) {
          if (state.queryParams["langID"] == null ||
              state.queryParams["classroomID"] == null ||
              state.queryParams["lessonId"] == null ||
              state.queryParams["examId"] == null) {
            return const NotFoundScreen();
          }
          return QustionsScreen(
            lessonId: state.queryParams["lessonId"]!,
            classroomId: state.queryParams["classroomID"]!,
            langId: state.queryParams["langID"]!,
            examId: state.queryParams["examId"]!,
          );
        },
      ),
    ],
  );
}
