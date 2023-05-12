import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/functions/validate_auth.dart';
import 'package:hassan_elbadawy_admin/models/classrooms_model.dart';
import 'package:hassan_elbadawy_admin/models/student_model.dart';
import 'package:hassan_elbadawy_admin/modules/students/form_sudent.dart';
import 'package:hassan_elbadawy_admin/modules/students/student_views.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';
import 'package:hassan_elbadawy_admin/widgets/textFormField.dart';

import '../../routes/routes.dart';
import 'cubit/student_cubit.dart';

class StudentsScreen extends StatelessWidget {
  StudentsScreen({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StudentCubit cubit = StudentCubit.get(context);

    if (cubit.allStudents.isEmpty) {
      cubit.getStudents();
    }
    return BlocConsumer<StudentCubit, StudentState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<StudentModel> students = [];
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            // backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  context.go(Uri(path: Paths.HOME).toString());
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text("الطلاب"),
            ),
            body: cubit.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 0),
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 2,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: CustomTextFormField(
                              text: "اكتب اسم الطالب للبحث",
                              controller: searchController,
                              color: Colors.grey[200],
                              isFilld: true,
                              textColor: Colors.black,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(10),
                                child: CircleAvatar(
                                  radius: 20,
                                  child: IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () {
                                      cubit.search(word: searchController.text);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: cubit.isSearching
                                ? cubit.searchedStudent.length
                                : cubit.allStudents.length,
                            (context, index) {
                              if (cubit.isSearching) {
                                students = cubit.searchedStudent;
                              } else {
                                students = cubit.allStudents;
                              }
                              return ListTile(
                                onTap: () {},
                                leading: const Icon(Icons.person),
                                title: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          minWidth: 200,
                                          maxWidth: 300,
                                        ),
                                        child: Text(
                                          students[index].studentName!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          minWidth: 150,
                                          maxWidth: 300,
                                        ),
                                        child: Text(
                                          students[index].studentPhone!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          minWidth: 200,
                                          maxWidth: 300,
                                        ),
                                        child: Text(
                                          ClassroomModel.allClassrooms
                                              .where((element) =>
                                                  element.id ==
                                                  students[index].langId!)
                                              .first
                                              .classrooms
                                              .where((element) =>
                                                  element.id ==
                                                  students[index].classroomId!)
                                              .first
                                              .name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          minWidth: 150,
                                          maxWidth: 300,
                                        ),
                                        child: Text(
                                          students[index].centerName!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      CustomButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return FormStudentScreen(
                                                    studentModel:
                                                        students[index]);
                                              });
                                        },
                                        text: "تعديل",
                                        color: Colors.blue,
                                        width: 130,
                                        height: 30,
                                      ),
                                      const SizedBox(width: 10),
                                      CustomButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return StudentViews(
                                                    studentModel:
                                                        students[index]);
                                              });
                                        },
                                        text: "المشاهدات",
                                        color: Colors.green,
                                        width: 150,
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    ).isLogin();
  }
}
