import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/functions/show_message.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/states.dart';
import 'package:hassan_elbadawy_admin/theme/theme.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';
import 'package:hassan_elbadawy_admin/widgets/textFormField.dart';

import '../../../functions/uploud_file.dart';

class FormFileScreen extends StatelessWidget {
  FormFileScreen({
    super.key,
    required this.lessonId,
  });

  String lessonId;

  TextEditingController fileNameController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                                text: "اسم الملف",
                                controller: fileNameController,
                                isFilld: true,
                                color: Colors.white,
                                textColor: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "برجاء كتابة اسم الملف";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    cubit.selectedPDF == null
                                        ? "اختر الملف ؟ "
                                        : "تم تحديد الملف",
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (cubit.selectedPDF == null) {
                                        cubit.selectPDF();
                                      } else {
                                        cubit.removePDF();
                                      }
                                    },
                                    child: Text(
                                      cubit.selectedPDF == null
                                          ? "اضغط هنا"
                                          : "حذف",
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              cubit.isActionLoading
                                  ? const CircularProgressIndicator(
                                      color: MyColors.mainColor,
                                    )
                                  : CustomButton(
                                      onPressed: () async {
                                        if (formkey.currentState!.validate()) {
                                          if (cubit.selectedPDF == null) {
                                            showMessage(
                                                message:
                                                    "يرجي اختيار الملف اولا",
                                                color: Colors.red);
                                          } else {
                                            await cubit.addNewFile(
                                              lessonId: lessonId,
                                              fileName: fileNameController.text,
                                            );

                                            Navigator.pop(context);
                                          }
                                        }
                                      },
                                      text: "آضافة",
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
