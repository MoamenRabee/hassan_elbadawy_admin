import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/functions/format_date.dart';
import 'package:hassan_elbadawy_admin/functions/validate_auth.dart';
import 'package:hassan_elbadawy_admin/modules/codes/add_group_codes_screen.dart';
import 'package:hassan_elbadawy_admin/modules/codes/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/codes/cubit/states.dart';
import 'package:hassan_elbadawy_admin/theme/theme.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';

import '../../routes/routes.dart';

class CodesScreen extends StatelessWidget {
  const CodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CodesCubit cubit = CodesCubit.get(context);
    cubit.getCodesGroup();
    return BlocConsumer<CodesCubit, CodeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      context.go(Paths.HOME);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  title: const Text("الآكواد"),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AddGroupCodesScreen();
                              });
                        },
                        text: "اضافة مجموعة",
                        width: 200,
                        color: Colors.white,
                        textColor: MyColors.mainColor,
                      ),
                    ),
                  ],
                  bottom: cubit.isLoadingGetGroups == false
                      ? const TabBar(
                          indicatorColor: MyColors.blackColor,
                          tabs: [
                            Tab(
                              child: Text("الجديدة"),
                            ),
                            Tab(
                              child: Text("المستخدمة"),
                            ),
                          ],
                        )
                      : null,
                ),
                body: cubit.isLoadingGetGroups || cubit.isLoadingAction
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: MyColors.mainColor))
                    : TabBarView(
                        children: [
                          cubit.allGroupNotPrinted.isEmpty
                              ? const Center(
                                  child: Text("لا يوجد مجموعات"),
                                )
                              : ListView.builder(
                                  itemCount: cubit.allGroupNotPrinted.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        context.go(
                                          Uri(
                                            path: Paths.ALL_CODES,
                                            queryParameters: {
                                              "groupId": cubit
                                                  .allGroupNotPrinted[index].id!
                                            },
                                          ).toString(),
                                        );
                                      },
                                      leading: const Icon(Icons.book),
                                      title: Text(cubit
                                          .allGroupNotPrinted[index].title
                                          .toString()),
                                      subtitle: Text(formatDate(cubit
                                          .allGroupNotPrinted[index]
                                          .dateTime!)),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: CustomButton(
                                              onPressed: () {
                                                cubit.toArchive(
                                                    cubit
                                                        .allGroupNotPrinted[
                                                            index]
                                                        .id
                                                        .toString(),
                                                    true);
                                              },
                                              text: "نقل الي الارشيف",
                                              width: 200,
                                              textColor: Colors.white,
                                              color: MyColors.blackColor,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: CustomButton(
                                              onPressed: () {
                                                cubit.deleteGroup(cubit
                                                    .allGroupNotPrinted[index]
                                                    .id
                                                    .toString());
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
                          cubit.allGroupPrinted.isEmpty
                              ? const Center(
                                  child: Text("لا يوجد مجموعات"),
                                )
                              : ListView.builder(
                                  itemCount: cubit.allGroupPrinted.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        context.go(
                                          Uri(
                                            path: Paths.ALL_CODES,
                                            queryParameters: {
                                              "groupId": cubit
                                                  .allGroupPrinted[index].id!
                                            },
                                          ).toString(),
                                        );
                                      },
                                      leading: const Icon(Icons.book),
                                      title: Text(cubit
                                          .allGroupPrinted[index].title
                                          .toString()),
                                      subtitle: Text(formatDate(cubit
                                          .allGroupPrinted[index].dateTime!)),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: CustomButton(
                                              onPressed: () {
                                                cubit.toArchive(
                                                    cubit.allGroupPrinted[index]
                                                        .id
                                                        .toString(),
                                                    false);
                                              },
                                              text: "نقل من الارشيف",
                                              width: 200,
                                              textColor: Colors.white,
                                              color: MyColors.blackColor,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: CustomButton(
                                              onPressed: () {
                                                cubit.deleteGroup(cubit
                                                    .allGroupPrinted[index].id
                                                    .toString());
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
                        ],
                      ),
              ),
            ),
          );
        }).isLogin();
  }
}
