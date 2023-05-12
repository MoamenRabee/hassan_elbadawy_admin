import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/models/classrooms_model.dart';
import 'package:hassan_elbadawy_admin/models/student_model.dart';
import 'package:hassan_elbadawy_admin/models/video_model.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/states.dart';
import 'package:hassan_elbadawy_admin/modules/students/cubit/student_cubit.dart';
import 'package:hassan_elbadawy_admin/theme/theme.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';
import 'package:hassan_elbadawy_admin/widgets/textFormField.dart';

import '../../../functions/my_validate.dart';

class FormStudentScreen extends StatelessWidget {
  FormStudentScreen({
    super.key,
    required this.studentModel,
  });

  StudentModel studentModel;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fatherPhoneController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    nameController.text = studentModel.studentName!;
    phoneController.text = studentModel.studentPhone!;
    fatherPhoneController.text = studentModel.fatherPhone!;

    StudentCubit cubit = StudentCubit.get(context);
    return BlocConsumer<StudentCubit, StudentState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 700,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formkey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextFormField(
                                prefixIcon: const Icon(Icons.person),
                                text: "اسم الطالب",
                                controller: nameController,
                                isFilld: true,
                                color: Colors.white,
                                textColor: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "برجاء كتابة اسم الطالب";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                prefixIcon: const Icon(Icons.phone),
                                text: "رقم الهاتف",
                                enabled: false,
                                controller: phoneController,
                                isFilld: true,
                                keyboardType: TextInputType.number,
                                color: Colors.white,
                                textColor: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "برجاء كتابة رقم الهاتف";
                                  }
                                  if (isNumeric(val)) {
                                    return "يرجي ادخال رقم";
                                  }
                                  if (val.length != 11) {
                                    return "رقم الهاتف غير صحيح";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                prefixIcon: const Icon(Icons.phone),
                                text: "رقم هاتف ولي الامر",
                                controller: fatherPhoneController,
                                isFilld: true,
                                keyboardType: TextInputType.number,
                                color: Colors.white,
                                textColor: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "برجاء كتابة رقم هاتف ولي الامر";
                                  }
                                  if (isNumeric(val)) {
                                    return "يرجي ادخال رقم";
                                  }
                                  if (val.length != 11) {
                                    return "رقم الهاتف غير صحيح";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                prefixIcon: const Icon(Icons.password),
                                text: "كلمه المرور",
                                controller: passwordController,
                                isFilld: true,
                                keyboardType: TextInputType.text,
                                color: Colors.white,
                                textColor: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                validator: (val) {
                                  if (val!.isNotEmpty) {
                                    if (val.length < 8) {
                                      return "يجب كتابه الباسورد ٨ حروف";
                                    }
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  ClassroomModel.allClassrooms
                                      .where((element) =>
                                          element.id == studentModel.langId)
                                      .first
                                      .name,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  ClassroomModel.allClassrooms
                                      .where((element) =>
                                          element.id == studentModel.langId)
                                      .first
                                      .classrooms
                                      .where((element) =>
                                          element.id ==
                                          studentModel.classroomId)
                                      .first
                                      .name,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: cubit.isLoadingUpdate
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: MyColors.mainColor,
                                            ),
                                          )
                                        : CustomButton(
                                            onPressed: () async {
                                              if (formkey.currentState!
                                                  .validate()) {
                                                cubit.updateStudent(
                                                  student: studentModel,
                                                  name: nameController.text,
                                                  fatherPhone:
                                                      fatherPhoneController
                                                          .text,
                                                  password:
                                                      passwordController.text,
                                                );

                                                Navigator.pop(context);
                                              }
                                            },
                                            text: "تعديل",
                                            color: MyColors.blackColor,
                                            textColor: Colors.white,
                                            width: 200,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: cubit.isLoadingNew
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: MyColors.mainColor,
                                            ),
                                          )
                                        : CustomButton(
                                            onPressed: () async {
                                              cubit.reNewStudent(
                                                  student: studentModel);
                                              Navigator.pop(context);
                                            },
                                            text: "تجديد",
                                            color: Colors.blue,
                                            textColor: Colors.white,
                                            width: 200,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: cubit.isLoadingDelete
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: MyColors.mainColor,
                                            ),
                                          )
                                        : CustomButton(
                                            onPressed: () async {
                                              cubit.deleteStudent(
                                                  student: studentModel);
                                              Navigator.pop(context);
                                            },
                                            text: "حذف الطالب",
                                            color: Colors.red,
                                            textColor: Colors.white,
                                            width: 200,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
