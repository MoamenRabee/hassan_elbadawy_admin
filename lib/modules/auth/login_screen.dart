import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/modules/auth/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/auth/cubit/states.dart';
import 'package:hassan_elbadawy_admin/theme/theme.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';
import 'package:hassan_elbadawy_admin/widgets/textFormField.dart';

import '../../constants/assets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);

    return BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: const Text("تسجيل الدخول للوحة التحكم"),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(50),
                        color: Colors.white,
                        height: 200,
                        width: 300,
                        child: Image.asset(
                          Assets.logo,
                        ),
                      ),
                      Container(
                        width: 500,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextFormField(
                                text: "البريد الإلكتروني",
                                controller: emailController,
                                isFilld: true,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                textColor: Colors.black,
                                prefixIcon: const Icon(Icons.email),
                                centerText: true,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "يرجي ادخال البريد الإلكتروني";
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              CustomTextFormField(
                                text: "كلمة المرور",
                                controller: passwordController,
                                isFilld: true,
                                isPassword: true,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                textColor: Colors.black,
                                prefixIcon: const Icon(Icons.password),
                                centerText: true,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "يرجي ادخال كلمة المرور";
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
              
                              cubit.isLoading ? CustomButtonLoading(
                                color: MyColors.mainColor,
                                textColor: Colors.white,
                                height: 50,
                                width: double.infinity,
                              ) : CustomButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.login(
                                      context: context,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                color: MyColors.mainColor,
                                textColor: Colors.white,
                                height: 50,
                                width: double.infinity,
                                text: "دخول",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
