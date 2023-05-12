import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/models/video_model.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/states.dart';
import 'package:hassan_elbadawy_admin/theme/theme.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';
import 'package:hassan_elbadawy_admin/widgets/textFormField.dart';

import '../../../functions/my_validate.dart';

class FormVideoScreen extends StatelessWidget {
  FormVideoScreen({
    super.key,
    required this.lessonId,
    required this.action,
    this.videoModel,
  });

  String lessonId;
  String action;
  VideoModel? videoModel;

  TextEditingController videoNameController = TextEditingController();
  TextEditingController videoDescController = TextEditingController();
  TextEditingController videoOrderNumberController = TextEditingController();
  TextEditingController videoURLController = TextEditingController();
  TextEditingController viewsCountController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (action != "add") {
      videoNameController.text = videoModel!.videoName!;
      videoDescController.text = videoModel!.videoDesc!;
      videoOrderNumberController.text = videoModel!.videoOrderNumber.toString();
      videoURLController.text = videoModel!.videoURL!;
      viewsCountController.text = videoModel!.viewsCount.toString();
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
                                text: "اسم الفيديو",
                                controller: videoNameController,
                                isFilld: true,
                                color: Colors.white,
                                textColor: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "برجاء كتابة اسم الفيديو";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                prefixIcon:
                                    const Icon(Icons.text_snippet_rounded),
                                text: "الوصف",
                                controller: videoDescController,
                                keyboardType: TextInputType.text,
                                isFilld: true,
                                color: Colors.white,
                                textColor: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "برجاء كتابة وصف الفيديو";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                prefixIcon: const Icon(Icons.link),
                                text: "الرابط",
                                controller: videoURLController,
                                isFilld: true,
                                keyboardType: TextInputType.text,
                                color: Colors.white,
                                textColor: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "برجاء كتابة رابط الفيديو";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                prefixIcon: const Icon(Icons.visibility),
                                text: "عدد مرات المشاهده",
                                controller: viewsCountController,
                                isFilld: true,
                                keyboardType: TextInputType.number,
                                color: Colors.white,
                                textColor: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "برجاء كتابة عدد مرات المشاهده";
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
                                prefixIcon: const Icon(Icons.numbers),
                                text: "الترتيب",
                                controller: videoOrderNumberController,
                                isFilld: true,
                                keyboardType: TextInputType.number,
                                color: Colors.white,
                                textColor: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "برجاء كتابة الترتيب";
                                  }
                                  if (isNumeric(val)) {
                                    return "يرجي ادخال رقم";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              cubit.isActionLoading
                                  ? const CircularProgressIndicator(
                                      color: MyColors.mainColor,
                                    )
                                  : CustomButton(
                                      onPressed: () async {
                                        if (formkey.currentState!.validate()) {
                                          if (action == "add") {
                                            await cubit.addNewVideo(
                                              lessonId: lessonId,
                                              videoName: videoNameController.text,
                                              videoDesc: videoDescController.text,
                                              videoURL: videoURLController.text,
                                              viewsCount:
                                                  viewsCountController.text,
                                              videoOrderNumber:
                                                  videoOrderNumberController.text,
                                            );
                                          } else {
                                            await cubit.updateVideo(
                                              lessonId: lessonId,
                                              videoName: videoNameController.text,
                                              videoId: videoModel!.videoId!,
                                              videoDesc: videoDescController.text,
                                              videoURL: videoURLController.text,
                                              viewsCount:
                                                  viewsCountController.text,
                                              videoOrderNumber:
                                                  videoOrderNumberController.text,
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
