import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/functions/validate_auth.dart';
import 'package:hassan_elbadawy_admin/theme/theme.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';
import 'package:hassan_elbadawy_admin/widgets/textFormField.dart';

import '../../routes/routes.dart';
import 'cubit/setting_cubit.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SettingCubit cubit = SettingCubit.get(context);
    cubit.getSettings();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  context.go(Uri(
                    path: Paths.HOME,
                  ).toString());
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text("الإعدادات"),
            ),
            body: cubit.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: SizedBox(
                          width: 500,
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  CustomTextFormField(
                                    text: "الواتساب",
                                    controller: cubit.whatsAppController,
                                    isFilld: true,
                                    color: Colors.white,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "يرجي كتابه رقم الواتساب";
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextFormField(
                                    text: "يوتيوب",
                                    controller: cubit.youtubeController,
                                    isFilld: true,
                                    color: Colors.white,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "يرجي كتابه رابط اليوتيوب";
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextFormField(
                                    text: "فيسبوك",
                                    controller: cubit.facebookController,
                                    isFilld: true,
                                    color: Colors.white,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "يرجي كتابه رابط الفيسبوك";
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  CustomButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.updateSettings();
                                      }
                                    },
                                    text: "تعديل",
                                    color: MyColors.mainColor,
                                    textColor: Colors.white,
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
      ).isLogin(),
    );
  }
}
