import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/models/news_model.dart';
import 'package:hassan_elbadawy_admin/modules/center/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/center/cubit/states.dart';
import 'package:hassan_elbadawy_admin/modules/news/cubit/news_cubit.dart';
import 'package:hassan_elbadawy_admin/theme/theme.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';
import 'package:hassan_elbadawy_admin/widgets/textFormField.dart';

class FormNewsScreen extends StatelessWidget {
  FormNewsScreen({super.key, required this.action, this.newsModel});

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController videoUrlController = TextEditingController();

  String action;
  NewsModel? newsModel;

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (action != "add") {
      titleController.text = newsModel!.title!;
      contentController.text = newsModel!.content!;
      videoUrlController.text = newsModel!.videoUrl!;
    }

    NewsCubit cubit = NewsCubit.get(context);
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Directionality(
            textDirection: TextDirection.rtl,
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
                                text: "العنوان",
                                controller: titleController,
                                isFilld: true,
                                color: Colors.white,
                                textColor: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "برجاء كتابة عنوان الخبر";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              CustomTextFormField(
                                text: "المحتوي",
                                controller: contentController,
                                isFilld: true,
                                color: Colors.white,
                                textColor: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                maxLines: 5,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "برجاء كتابة الخبر";
                                  }
                                  return null;
                                },
                              ),
                              // const SizedBox(height: 10),
                              // CustomTextFormField(
                              //   text: "رابط فيديو علي اليوتيوب",
                              //   controller: videoUrlController,
                              //   isFilld: true,
                              //   color: Colors.white,
                              //   textColor: Colors.black,
                              //   borderRadius: BorderRadius.circular(5),
                              // ),
                              const SizedBox(height: 10),
                              if (action != "add" && newsModel!.image! != "")
                                const Text(
                                  "يوجد صورة في الخبر",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (action != "add" && newsModel?.image! != "")
                                const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    cubit.selectedImage == null
                                        ? "هل تريد آضافة صوره للخبر ؟ "
                                        : "تم تحديد صورة",
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (cubit.selectedImage == null) {
                                        cubit.selectNewsImage();
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
                              const SizedBox(height: 20),
                              cubit.isLoading || cubit.isLoadingActionUpdate
                                  ? const CircularProgressIndicator(
                                      color: MyColors.mainColor,
                                    )
                                  : CustomButton(
                                      onPressed: () async {
                                        if (formkey.currentState!.validate()) {
                                          if (action == "add") {
                                            await cubit
                                                .addNews(
                                              title: titleController.text,
                                              content: contentController.text,
                                              videoUrl: videoUrlController.text,
                                            )
                                                .then((value) {
                                              Navigator.pop(context);
                                            });
                                          } else {
                                             await cubit
                                                .editNews(
                                                  oldNewsModel: newsModel!,
                                              title: titleController.text,
                                              content: contentController.text,
                                              videoUrl: videoUrlController.text,
                                            )
                                                .then((value) {
                                              Navigator.pop(context);
                                            });
                                          }
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
