import 'package:flutter/material.dart';
import 'package:hassan_elbadawy_admin/functions/validate_auth.dart';
import 'package:hassan_elbadawy_admin/modules/layout/drawer.dart';

import '../home/HomeScreen.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer:
            MediaQuery.of(context).size.width < 1000 ? const MyDrawer() : null,
        appBar: AppBar(
          title: const Text("لوحة التحكم"),
        ),
        body: Row(
          children: [
            if (MediaQuery.of(context).size.width > 1000) const MyDrawer(),
            const Expanded(
              flex: 10,
              child: HomeScreen(),
            ),
          ],
        ),
      ),
    ).isLogin();
  }
}
