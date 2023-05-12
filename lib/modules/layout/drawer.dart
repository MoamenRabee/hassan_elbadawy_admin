import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/modules/auth/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/routes/routes.dart';

import '../../constants/assets.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        ),
      ),
      child: Column(
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
          drawerItem(
              icon: Icons.qr_code,
              title: "الأكواد",
              onTap: () {
                // context.go(Uri(path:"/codes",queryParameters: {"name":"ali mohamed"}).toString());
                context.go(Uri(path: Paths.CODES).toString());
              }),
          drawerItem(
              icon: Icons.class_rounded,
              title: "السناتر",
              onTap: () {
                context.go(Uri(path: Paths.CENTERS).toString());
              }),
          drawerItem(
              icon: Icons.people_alt,
              title: "الطلاب",
              onTap: () {
                context.go(Uri(path: Paths.STUDENTS).toString());
              }),
          drawerItem(
              icon: Icons.smart_display,
              title: "محتوي الآبلكيشن",
              onTap: () {
                context.go(Uri(path: Paths.CLASSROOMS).toString());
              }),
          drawerItem(
            icon: Icons.calendar_month,
            title: "نظام الشهر",
            onTap: () {
              context.go(Uri(path: Paths.MONTHLY).toString());
            },
          ),
          drawerItem(
            icon: Icons.newspaper,
            title: "الأخبار",
            onTap: () {
              context.go(Uri(path: Paths.NEWS).toString());
            },
          ),
          const Divider(),
          drawerItem(
              icon: Icons.settings,
              title: "الإعدادات",
              onTap: () {
                context.go(Uri(path: Paths.SETTINGS).toString());
              }),
          const Divider(),
          drawerItem(
              icon: Icons.logout,
              title: "تسجيل الخروج",
              onTap: () {
                AuthCubit.get(context).logOut(context: context);
              }),
        ],
      ),
    );
  }
}

Widget drawerItem({
  required String title,
  required IconData icon,
  required Function() onTap,
}) {
  return ListTile(
    onTap: onTap,
    iconColor: Colors.black,
    textColor: Colors.black,
    leading: Icon(icon),
    title: Row(
      children: [
        Text(title),
      ],
    ),
  );
}
