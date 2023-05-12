import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/routes/routes.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';

import '../theme/theme.dart';

class NotLoggedInScreen extends StatelessWidget {
  const NotLoggedInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("عفواً يرجي تسجيل الدخول اولآ",style: TextStyle(
              color: Colors.grey,
              fontSize: 30,
            ),),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
              onPressed: () {
                context.go(Paths.LOGIN);
              },
              color: MyColors.mainColor,
              textColor: Colors.white,
              height: 50,
              text: "تسجيل دخول",
            ),
          ],
        ),
      ),
    );
  }
}
