import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/functions/validate_auth.dart';
import 'package:hassan_elbadawy_admin/modules/home/cubit/home_cubit.dart';
import 'package:hassan_elbadawy_admin/modules/home/widgets/home_card.dart';
import 'package:hassan_elbadawy_admin/modules/home/widgets/home_comment_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    cubit.getAnalysis();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: cubit.isLoadingAnalysis
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Wrap(
                        children: [
                          homeCard(
                            icon: Icons.people_alt,
                            title: "عدد الطلاب",
                            count: cubit.studentCount.toString(),
                          ),
                          homeCard(
                            icon: Icons.remove_red_eye,
                            title: "عدد المشاهدات",
                            count: cubit.viewsCount.toString(),
                          ),
                          homeCard(
                            icon: Icons.video_collection_rounded,
                            title: "عدد الدروس",
                            count: cubit.lessonsCount.toString(),
                          ),
                          homeCard(
                            icon: Icons.file_copy_sharp,
                            title: "عدد الملفات",
                            count: cubit.filesCount.toString(),
                          ),
                          homeCard(
                            icon: Icons.checklist_rtl_sharp,
                            title: "عدد الأختبارات",
                            count: cubit.examsCount.toString(),
                          ),
                        ],
                      ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "التعليقات",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Expanded(
                child: cubit.isLoadingComments
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : cubit.allComments.isEmpty
                        ? const Center(
                            child: Text("لا يوجد تعليقات الآن"),
                          )
                        : ListView.builder(
                            itemCount: cubit.allComments.length,
                            itemBuilder: (context, index) {
                              return homeCommentCard(
                                context,
                                cubit.allComments[index],
                              );
                            },
                          ),
              ),
            ],
          ),
        );
      },
    ).isLogin();
  }
}
