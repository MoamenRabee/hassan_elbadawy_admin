import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/models/exam_model.dart';
import 'package:hassan_elbadawy_admin/models/video_model.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/states.dart';
import 'package:hassan_elbadawy_admin/theme/theme.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';
import 'package:hassan_elbadawy_admin/widgets/textFormField.dart';

import '../../../functions/my_validate.dart';

class FormExamScreen extends StatelessWidget {
  FormExamScreen({
    super.key,
    required this.lessonId,
    required this.action,
    this.examModel,
  });

  String lessonId;
  String action;
  ExamModel? examModel;

  TextEditingController nameController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (action != "add") {
      nameController.text = examModel!.examName!;
    }

    LessonCubit cubit = LessonCubit.get(context);
    return BlocConsumer<LessonCubit, LessonStates>(
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
                                prefixIcon: const Icon(Icons.text_format),
                                text: "اسم الاختبار",
                                controller: nameController,
                                isFilld: true,
                                color: Colors.white,
                                textColor: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "برجاء كتابة اسم الاختبار";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              cubit.isLoadingActionExam
                                  ? const CircularProgressIndicator(
                                      color: MyColors.mainColor,
                                    )
                                  : CustomButton(
                                      onPressed: () async {
                                        if (formkey.currentState!.validate()) {
                                          if (action == "add") {
                                            cubit.addNewExam(
                                              examName: nameController.text,
                                              lessonId: lessonId,
                                            );
                                          } else {
                                            cubit.updateExam(
                                              examId: examModel!.examId!,
                                              examName: nameController.text,
                                              lessonId: lessonId,
                                            );
                                          }
                        
                                          Navigator.pop(context);
                                        }
                                      },
                                      text: action == "add" ? "آضافة" : "تعديل",
                                      color: MyColors.mainColor,
                                      textColor: Colors.white,
                                      width: 200,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
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
