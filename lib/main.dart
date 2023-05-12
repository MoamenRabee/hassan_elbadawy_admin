import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/functions/cache_helper.dart';
import 'package:hassan_elbadawy_admin/firebase_options.dart';
import 'package:hassan_elbadawy_admin/modules/auth/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/center/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/codes/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/content/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/home/cubit/home_cubit.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/monthly/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/news/cubit/news_cubit.dart';
import 'package:hassan_elbadawy_admin/modules/qustions/cubit/qustion_cubit.dart';
import 'package:hassan_elbadawy_admin/modules/settings/cubit/setting_cubit.dart';
import 'package:hassan_elbadawy_admin/modules/students/cubit/student_cubit.dart';
import 'package:hassan_elbadawy_admin/routes/routes.dart';
import 'package:hassan_elbadawy_admin/theme/theme.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => HomeCubit()
              ..getComments()
              ..getAnalysis()),
        BlocProvider(create: (context) => CodesCubit()),
        BlocProvider(create: (context) => CenterCubit()),
        BlocProvider(create: (context) => ContentCubit()),
        BlocProvider(create: (context) => LessonCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => StudentCubit()),
        BlocProvider(create: (context) => QustionCubit()),
        BlocProvider(create: (context) => SettingCubit()),
        BlocProvider(create: (context) => MonthlyCubit()),
        BlocProvider(create: (context) => NewsCubit()),
      ],
      child: MaterialApp.router(
        title: 'Scientist Admin Panal',
        debugShowCheckedModeBanner: false,
        theme: MyTheme.adminTheme,
        routerConfig: Routes.router,
      ),
    );
  }
}
