import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/functions/my_validate.dart';
import 'package:hassan_elbadawy_admin/modules/codes/cubit/states.dart';

import '../../theme/theme.dart';
import '../../widgets/buttons.dart';
import '../../widgets/textFormField.dart';
import 'cubit/cubit.dart';

class AddCodesScreen extends StatelessWidget {
  AddCodesScreen({super.key, required this.groupId});

  TextEditingController countController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String groupId;

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CodesCubit cubit = CodesCubit.get(context);
    return BlocConsumer<CodesCubit, CodeStates>(
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
                  height: 300,
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
                              cubit.isLoadingAction
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Text(
                                          cubit.codesAddedDone.toString(),
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 60,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomTextFormField(
                                          text: "عدد الاكواد المراد اضافتها",
                                          controller: countController,
                                          isFilld: true,
                                          color: Colors.white,
                                          textColor: Colors.black,
                                          keyboardType: TextInputType.number,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "برجاء كتابة العدد";
                                            }
                                            if (isNumeric(val)) {
                                              return "يرجي ادخال رقم";
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 20),
                                        CustomTextFormField(
                                          text: "سعر الاكواد",
                                          controller: priceController,
                                          isFilld: true,
                                          color: Colors.white,
                                          textColor: Colors.black,
                                          keyboardType: TextInputType.number,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "برجاء كتابة السعر";
                                            }
                                            if (isNumeric(val)) {
                                              return "يرجي ادخال رقم";
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              cubit.isLoadingAction
                                  ? const CircularProgressIndicator(
                                      color: MyColors.mainColor,
                                    )
                                  : CustomButton(
                                      onPressed: () async {
                                        if (formkey.currentState!.validate()) {
                                          cubit.addCodes(
                                            context: context,
                                            groupId: groupId,
                                            codesTotalCount:
                                                int.parse(countController.text),
                                            priceCodes:
                                                int.parse(priceController.text),
                                          );
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
