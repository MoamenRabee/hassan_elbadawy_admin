import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/functions/validate_auth.dart';
import 'package:hassan_elbadawy_admin/models/classrooms_model.dart';
import 'package:hassan_elbadawy_admin/modules/content/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/content/cubit/states.dart';
import 'package:hassan_elbadawy_admin/theme/theme.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';

import '../../routes/routes.dart';

class ClassroomsScreen extends StatelessWidget {
  const ClassroomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ContentCubit cubit = ContentCubit.get(context);
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
          title: const Text("الصفوف الداسية"),
          
        ),
        body: BlocConsumer<ContentCubit, ContentStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "اختر لغه التدريس",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField(
                          hint: const Text("اضغط لإختيار لغة التدريس"),
                          items: ClassroomModel.allClassrooms
                              .map((e) => DropdownMenuItem(
                                    value: e.id,
                                    alignment: Alignment.center,
                                    child: Text(e.name),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            cubit.selectLang(val.toString());
                            cubit.selectedClassroom = null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        if (cubit.selectedLang != null)
                          Column(
                            children: [
                              const SizedBox(height: 30),
                              const Text(
                                "اختر الصف الدراسي",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              DropdownButtonFormField(
                                value: cubit.selectedClassroom,
                                hint: const Text("اضغط لإختيار الصف الدراسي"),
                                items: ClassroomModel.allClassrooms
                                    .where((element) =>
                                        element.id == cubit.selectedLang)
                                    .first
                                    .classrooms
                                    .map((e) => DropdownMenuItem(
                                          value: e.id.toString(),
                                          alignment: Alignment.center,
                                          child: Text(e.name),
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  cubit.selectClassroom(val.toString());
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (cubit.selectedLang != null &&
                            cubit.selectedClassroom != null)
                          Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              CustomButton(
                                onPressed: () {
                                  context.go(Uri(
                                      path: Paths.CONTENT,
                                      queryParameters: {
                                        "langID": cubit.selectedLang,
                                        "classroomID": cubit.selectedClassroom,
                                      }).toString());
                                },
                                text: "دخول",
                                color: MyColors.mainColor,
                                textColor: Colors.white,
                                width: double.infinity,
                                height: 50,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    ).isLogin();
  }
}
