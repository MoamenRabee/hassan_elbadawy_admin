import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/models/lesson_model.dart';
import 'package:hassan_elbadawy_admin/modules/center/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/center/cubit/states.dart';
import 'package:hassan_elbadawy_admin/modules/content/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/content/cubit/states.dart';
import 'package:hassan_elbadawy_admin/theme/theme.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';
import 'package:hassan_elbadawy_admin/widgets/textFormField.dart';

import '../../functions/my_validate.dart';

class FormLessonScreen extends StatelessWidget {
  FormLessonScreen({
    super.key,
    required this.langID,
    required this.classroomID,
    required this.action,
    this.lessonModel,
  });

  String langID;
  String classroomID;
  String action;
  LessonModel? lessonModel;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController orderNumberController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ContentCubit cubit = ContentCubit.get(context);


    if (action != "add") {
      nameController.text = lessonModel!.lessonName!;
      priceController.text = lessonModel!.lessonPrice!;
      orderNumberController.text = lessonModel!.lessonOrderNumber!.toString();
      cubit.isFree = lessonModel!.isFree!;
    }

    
    return BlocConsumer<ContentCubit, ContentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 700,
                height: 400,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextFormField(
                            text: "اسم الدرس",
                            controller: nameController,
                            isFilld: true,
                            color: Colors.white,
                            textColor: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "برجاء كتابة اسم الدرس";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            text: "السعر",
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            isFilld: true,
                            color: Colors.white,
                            textColor: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "برجاء كتابة سعر الدرس";
                              }
                              if (isNumeric(val)) {
                                return "يرجي ادخال رقم";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            text: "الترتيب",
                            controller: orderNumberController,
                            isFilld: true,
                            keyboardType: TextInputType.number,
                            color: Colors.white,
                            textColor: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "برجاء كتابة ترتيب الدرس";
                              }
                              if (isNumeric(val)) {
                                return "يرجي ادخال رقم";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CheckboxListTile(
                            activeColor: MyColors.mainColor,
                            value: cubit.isFree,
                            onChanged: (val) {
                              cubit.chageIsFree(val!);
                            },
                            title: const Text("هل هذا الدرس مجاني"),
                          ),
                          if (action != "add" &&
                                  lessonModel!.lessonImage! != "")
                                const Text(
                                  "يوجد صورة في الدرس",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          if (action != "add" &&
                                  lessonModel?.lessonImage! != "")
                                const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    cubit.selectedImage == null
                                        ? "هل تريد آضافة صوره للسؤال ؟ "
                                        : "تم تحديد صورة",
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (cubit.selectedImage == null) {
                                        cubit.selectLessonImage();
                                      } else {
                                        cubit.removeImage();
                                      }
                                    },
                                    child: Text(
                                      cubit.selectedImage == null
                                          ? "إختيار صورة"
                                          : "حذف",
                                    ),
                                  ),
                                ],
                              ),
                          const Spacer(),
                          cubit.isLoadingAction
                              ? const CircularProgressIndicator(
                                  color: MyColors.mainColor,
                                )
                              : CustomButton(
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      if (action == "add") {
                                        await cubit.addNewLesson(
                                          langID: langID,
                                          classroomID: classroomID,
                                          name: nameController.text,
                                          price: priceController.text,
                                          orderNumber: int.parse(
                                            orderNumberController.text,
                                          ),
                                          isFree: cubit.isFree,
                                        );
                                      } else {
                                        await cubit.editLesson(
                                          oldLessonModel: lessonModel!,
                                          name: nameController.text,
                                          price: priceController.text,
                                          orderNumber: int.parse(
                                            orderNumberController.text,
                                          ),
                                          isFree: cubit.isFree,
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
        );
      },
    );
  }
}
