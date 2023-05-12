import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/functions/functions.dart';
import 'package:hassan_elbadawy_admin/models/classrooms_model.dart';
import 'package:hassan_elbadawy_admin/modules/monthly/form_monthly.dart';
import 'package:hassan_elbadawy_admin/modules/monthly/widgets/delete_month_dialog.dart';

import '../../routes/routes.dart';
import '../../theme/theme.dart';
import '../../widgets/buttons.dart';
import 'cubit/cubit.dart';

class MonthlyScreen extends StatelessWidget {
  const MonthlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MonthlyCubit cubit = MonthlyCubit.get(context);

    cubit.getMonthlySystems();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<MonthlyCubit, MonthlyState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  context.go(Paths.HOME);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text("انظمة الشهر"),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return FormMonthlyScreen(
                              action: "add",
                            );
                          });
                    },
                    text: "اضافة شهر",
                    width: 200,
                    color: Colors.white,
                    textColor: MyColors.mainColor,
                  ),
                ),
              ],
            ),
            body: cubit.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : cubit.allMonthlySystems.isEmpty
                    ? const Center(
                        child: Text("لا يوجد آنظمه شهر"),
                      )
                    : ListView.separated(
                        itemCount: cubit.allMonthlySystems.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              context.go(Uri(
                                  path: Paths.MONTHLY_CONTENT,
                                  queryParameters: {
                                    "monthlySystemId":
                                        cubit.allMonthlySystems[index].systemId,
                                  }).toString());
                            },
                            leading: const Icon(Icons.calendar_month),
                            title: Text(
                                cubit.allMonthlySystems[index].systemName!),
                            subtitle: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getClassroomName(int.parse(cubit
                                      .allMonthlySystems[index].classroomId!)),
                                ),
                                Text(getLangName(
                                    cubit.allMonthlySystems[index].langId!)),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return FormMonthlyScreen(
                                              action: "edit",
                                              monthlySystemModel: cubit
                                                  .allMonthlySystems[index],
                                            );
                                          });
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return deleteMonthDialog(
                                              context: context,
                                              systemId: cubit
                                                  .allMonthlySystems[index]
                                                  .systemId!);
                                        });
                                  },
                                  icon: const Icon(Icons.delete),
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
