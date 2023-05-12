import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/models/exam_model.dart';
import 'package:hassan_elbadawy_admin/models/video_model.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/lesson_content/cubit/states.dart';
import 'package:hassan_elbadawy_admin/modules/qustions/cubit/qustion_cubit.dart';
import 'package:hassan_elbadawy_admin/theme/theme.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';
import 'package:hassan_elbadawy_admin/widgets/textFormField.dart';

import '../../functions/my_validate.dart';

class FormQustionScreen extends StatelessWidget {
  FormQustionScreen({
    super.key,
    required this.action,
    required this.examId,
    this.questionModel,
  });

  String action;
  String examId;
  QuestionModel? questionModel;

  TextEditingController qustionController = TextEditingController();
  TextEditingController answer1Controller = TextEditingController();
  TextEditingController answer2Controller = TextEditingController();
  TextEditingController answer3Controller = TextEditingController();
  TextEditingController answer4Controller = TextEditingController();
  int? currectAnswer;
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    QustionCubit cubit = QustionCubit.get(context);

    if (action != "add") {
      qustionController.text = questionModel!.question!;
      answer1Controller.text = questionModel!.answers![0];
      answer2Controller.text = questionModel!.answers![1];
      answer3Controller.text = questionModel!.answers![2];
      answer4Controller.text = questionModel!.answers![3];
      cubit.selectedAnswer = questionModel!.correctAnswer!;
    }

    return BlocConsumer<QustionCubit, QustionState>(
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
                                text: "السؤال",
                                controller: qustionController,
                                isFilld: true,
                                color: Colors.white,
                                textColor: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                maxLines: 3,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "برجاء كتابة السؤال";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Radio(
                                    value: 0,
                                    groupValue: cubit.selectedAnswer,
                                    onChanged: (val) {
                                      cubit.selectAnswer(
                                          int.parse(val.toString()));
                                    },
                                  ),
                                  Expanded(
                                    child: CustomTextFormField(
                                      text: "الآجابة الآولي",
                                      controller: answer1Controller,
                                      isFilld: true,
                                      color: Colors.white,
                                      textColor: Colors.black,
                                      borderRadius: BorderRadius.circular(5),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "برجاء كتابة الآجابة الآولي";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: cubit.selectedAnswer,
                                    onChanged: (val) {
                                      cubit.selectAnswer(
                                          int.parse(val.toString()));
                                    },
                                  ),
                                  Expanded(
                                    child: CustomTextFormField(
                                      text: "الآجابة الثانية",
                                      controller: answer2Controller,
                                      isFilld: true,
                                      color: Colors.white,
                                      textColor: Colors.black,
                                      borderRadius: BorderRadius.circular(5),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "برجاء كتابة الآجابة الثانية";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Radio(
                                    value: 2,
                                    groupValue: cubit.selectedAnswer,
                                    onChanged: (val) {
                                      cubit.selectAnswer(
                                          int.parse(val.toString()));
                                    },
                                  ),
                                  Expanded(
                                    child: CustomTextFormField(
                                      text: "الآجابة الثالثة",
                                      controller: answer3Controller,
                                      isFilld: true,
                                      color: Colors.white,
                                      textColor: Colors.black,
                                      borderRadius: BorderRadius.circular(5),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "برجاء كتابة الآجابة الثالثة";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Radio(
                                    value: 3,
                                    groupValue: cubit.selectedAnswer,
                                    onChanged: (val) {
                                      cubit.selectAnswer(
                                          int.parse(val.toString()));
                                    },
                                  ),
                                  Expanded(
                                    child: CustomTextFormField(
                                      text: "الآجابة الرابعة",
                                      controller: answer4Controller,
                                      isFilld: true,
                                      color: Colors.white,
                                      textColor: Colors.black,
                                      borderRadius: BorderRadius.circular(5),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "برجاء كتابة الآجابة الرابعة";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              if (action != "add" &&
                                  questionModel!.questionImage! != "")
                                const Text(
                                  "يوجد صورة في السؤال",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (action != "add" &&
                                  questionModel?.questionImage! != "")
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
                                        cubit.selectQuestionImage();
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
                              cubit.isLoadingAction
                                  ? const CircularProgressIndicator(
                                      color: MyColors.mainColor,
                                    )
                                  : CustomButton(
                                      onPressed: () async {
                                        if (formkey.currentState!.validate()) {
                                          if (action == "add") {
                                            await cubit.addNewQuestions(
                                              examId: examId,
                                              qustion: qustionController.text,
                                              answer1: answer1Controller.text,
                                              answer2: answer2Controller.text,
                                              answer3: answer3Controller.text,
                                              answer4: answer4Controller.text,
                                              correctAnswer:
                                                  cubit.selectedAnswer,
                                            );
                                            Navigator.pop(context);
                                          } else {
                                            await cubit.editQuestion(
                                              questionModel: questionModel!,
                                              examId: examId,
                                              qustion: qustionController.text,
                                              answer1: answer1Controller.text,
                                              answer2: answer2Controller.text,
                                              answer3: answer3Controller.text,
                                              answer4: answer4Controller.text,
                                              correctAnswer:
                                                  cubit.selectedAnswer,
                                            );
                                            Navigator.pop(context);
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
