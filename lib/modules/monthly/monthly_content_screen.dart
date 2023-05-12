import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/theme/theme.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';

import '../../routes/routes.dart';
import 'cubit/cubit.dart';

class MonthlyContentScreen extends StatelessWidget {
  MonthlyContentScreen({super.key, required this.monthlySystemId});

  String monthlySystemId;

  @override
  Widget build(BuildContext context) {
    MonthlyCubit cubit = MonthlyCubit.get(context);

    cubit.getLessonsInMonthlySystems(
      context: context,
      systemId: monthlySystemId,
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<MonthlyCubit, MonthlyState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  context.go(Uri(
                    path: Paths.MONTHLY,
                  ).toString());
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text("محتوي نظام الشهر"),
            ),
            body: cubit.isLoading || cubit.isLoadingLessons
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : cubit.allLessons.isEmpty
                    ? const Center(
                        child: Text("لا يوجد دروس"),
                      )
                    : cubit.addLessonLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: MyColors.blackColor,
                            ),
                          )
                        : ListView.builder(
                            itemCount: cubit.allLessons.length,
                            itemBuilder: (context, index) {
                              bool inMonth = cubit.monthlySystemModel!.lessons!
                                  .contains(cubit.allLessons[index].lessonId);
                              return ListTile(
                                tileColor: inMonth
                                    ? Colors.green[300]
                                    : Colors.grey[300],
                                onTap: () {},
                                title:
                                    Text(cubit.allLessons[index].lessonName!),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomButton(
                                      onPressed: () async {
                                        await cubit.addLessonFromMonthlySystem(
                                          context: context,
                                          lessonModel: cubit.allLessons[index],
                                          monthlySystemId: monthlySystemId,
                                        );
                                      },
                                      text: "اضافة",
                                      color: Colors.green,
                                      height: 30,
                                      width: 100,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomButton(
                                      onPressed: () async {
                                        await cubit
                                            .removeLessonFromMonthlySystem(
                                          context: context,
                                          lessonModel: cubit.allLessons[index],
                                          monthlySystemId: monthlySystemId,
                                        );
                                      },
                                      text: "ازالة",
                                      height: 30,
                                      color: Colors.black,
                                      width: 100,
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
