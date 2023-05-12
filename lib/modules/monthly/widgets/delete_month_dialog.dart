import 'package:flutter/material.dart';
import 'package:hassan_elbadawy_admin/modules/monthly/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/widgets/buttons.dart';

AlertDialog deleteMonthDialog({
  required BuildContext context,
  required String systemId,
}) =>
    AlertDialog(
      content: const Text("هل انت متآكد من عملية الحذف ؟"),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        CustomButton(
          onPressed: () {
            Navigator.pop(context);
            MonthlyCubit.get(context).deleteMonth(systemId);
          },
          text: "نعم",
          color: Colors.red,
          width: 100,
          height: 30,
          textColor: Colors.white,
        ),
      ],
    );
