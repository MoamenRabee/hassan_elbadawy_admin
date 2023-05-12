import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/models/lesson_model.dart';
import 'package:hassan_elbadawy_admin/models/monthly_system_model.dart';
import 'package:hassan_elbadawy_admin/modules/center/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/center/cubit/states.dart';
import 'package:hassan_elbadawy_admin/modules/content/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/content/cubit/states.dart';
import 'package:hassan_elbadawy_admin/modules/monthly/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/theme/theme.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';
import 'package:hassan_elbadawy_admin/widgets/textFormField.dart';

import '../../functions/my_validate.dart';
import '../../models/classrooms_model.dart';

class FormMonthlyScreen extends StatelessWidget {
  FormMonthlyScreen({
    super.key,
    required this.action,
    this.monthlySystemModel,
  });

  String action;
  MonthlySystemModel? monthlySystemModel;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController orderNumberController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MonthlyCubit cubit = MonthlyCubit.get(context);

    if (action != "add") {
      nameController.text = monthlySystemModel!.systemName!;
      priceController.text = monthlySystemModel!.systemPrice!;
      orderNumberController.text =
          monthlySystemModel!.systemOrderNumber!.toString();
    }

    return BlocConsumer<MonthlyCubit, MonthlyState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
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
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (action == "add")
                              DropdownButtonFormField(
                                hint: const Text("اضغط لإختيار لغة التدريس"),
                                validator: (val) {
                                  if (val == null) {
                                    return "برجاء إختيار اللغة";
                                  }

                                  return null;
                                },
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
                                      borderSide: const BorderSide(width: 0)),
                                ),
                              ),
                            if (action == "add")
                              const SizedBox(
                                height: 10,
                              ),
                            if (action == "add")
                              if (cubit.selectedLang != null)
                                DropdownButtonFormField(
                                  value: cubit.selectedClassroom,
                                  validator: (val) {
                                    if (val == null) {
                                      return "برجاء إختيار الصف الدراسي";
                                    }

                                    return null;
                                  },
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
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextFormField(
                              text: "اسم الشهر",
                              controller: nameController,
                              isFilld: true,
                              color: Colors.white,
                              textColor: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "برجاء كتابة اسم الشهر";
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
                                  return "برجاء كتابة سعر الشهر";
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
                                  return "برجاء كتابة ترتيب الشهر";
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
                            const Spacer(),
                            cubit.isLoadingAction
                                ? const CircularProgressIndicator(
                                    color: MyColors.mainColor,
                                  )
                                : CustomButton(
                                    onPressed: () async {
                                      if (formkey.currentState!.validate()) {
                                        if (action == "add") {
                                          await cubit.addMonth(
                                            langID: cubit.selectedLang!,
                                            classroomID:
                                                cubit.selectedClassroom!,
                                            name: nameController.text,
                                            price: priceController.text,
                                            orderNumber: int.parse(
                                              orderNumberController.text,
                                            ),
                                          );
                                        } else {
                                          await cubit.updateMonth(
                                            name: nameController.text,
                                            price: priceController.text,
                                            orderNumber: int.parse(
                                                orderNumberController.text),
                                            monthlySystemModel:
                                                monthlySystemModel!,
                                          );
                                        }

                                        Navigator.pop(context);
                                      }
                                    },
                                    text: action == "edit" ? "تعديل" : "آضافة",
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
        );
      },
    );
  }
}
