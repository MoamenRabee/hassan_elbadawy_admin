import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/functions/validate_auth.dart';
import 'package:hassan_elbadawy_admin/modules/center/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/center/cubit/states.dart';
import 'package:hassan_elbadawy_admin/theme/theme.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';

import '../../routes/routes.dart';
import 'add_new_center_screen.dart';

class CentersScreen extends StatelessWidget {
  const CentersScreen({super.key});

  @override
  Widget build(BuildContext context) {

    CenterCubit cubit = CenterCubit.get(context);
    cubit.allCenters = [];
    cubit.getCenters();
    return BlocConsumer<CenterCubit, CenterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    context.go(Paths.HOME);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                title: const Text("السناتر"),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AddNewCenterScreen();
                            });
                      },
                      text: "اضافة سنتر",
                      width: 200,
                      color: Colors.white,
                      textColor: MyColors.mainColor,
                    ),
                  ),
                ],
                
              ),
              body: cubit.isLoadingGetCenters || cubit.isLoadingAction
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: MyColors.mainColor))
                  : cubit.allCenters.isEmpty
                            ? const Center(
                                child: Text("لا يوجد سناتر"),
                              )
                            : ListView.builder(
                                itemCount: cubit.allCenters.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: const Icon(Icons.book),
                                    title: Text(cubit
                                        .allCenters[index].name
                                        .toString()),
                                    
                                    trailing: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: CustomButton(
                                        onPressed: () {
                                          cubit.deleteCenter(cubit.allCenters[index].id.toString());
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
            ),
          );
        }).isLogin();
  }
}
