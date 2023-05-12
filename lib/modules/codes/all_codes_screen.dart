import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/functions/show_message.dart';
import 'package:hassan_elbadawy_admin/functions/validate_auth.dart';
import 'package:hassan_elbadawy_admin/modules/codes/cubit/cubit.dart';
import 'package:hassan_elbadawy_admin/modules/codes/cubit/states.dart';

import '../../routes/routes.dart';
import '../../theme/theme.dart';
import '../../widgets/buttons.dart';
import 'add_codes_screen.dart';

class AllCodesScreen extends StatelessWidget {
  AllCodesScreen({super.key, required this.groupId});

  String groupId;

  @override
  Widget build(BuildContext context) {
    CodesCubit cubit = CodesCubit.get(context);
    cubit.getCodes(groupId: groupId);
    return BlocConsumer<CodesCubit, CodeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  context.go(Paths.CODES);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text("الآكواد"),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AddCodesScreen(
                            groupId: groupId,
                          );
                        },
                      );
                    },
                    text: "اضافه آكواد",
                    width: 200,
                    color: Colors.white,
                    textColor: MyColors.mainColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: cubit.isFileDownloadLoading
                      ? CustomButtonLoading(
                          width: 150,
                          color: MyColors.blackColor,
                          textColor: Colors.white,
                        )
                      : CustomButton(
                          onPressed: () {
                            cubit.downloadCodesAsExcelFile(groupId: groupId);
                          },
                          text: "تحميل",
                          width: 150,
                          color: MyColors.blackColor,
                          textColor: Colors.white,
                        ),
                ),
              ],
            ),
            body: cubit.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: MyColors.mainColor))
                : ListView.builder(
                    itemCount: cubit.allCodes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.code),
                        title: Text(cubit.allCodes[index].code.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: CustomButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: cubit.allCodes[index].code
                                          .toString()));
                                  showMessage(message: "تم نسخ الكود");
                                },
                                text: "نسخ",
                                width: 100,
                                textColor: Colors.white,
                                color: MyColors.blackColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: CustomButton(
                                onPressed: () {
                                  cubit.deleteCode(
                                    cubit.allCodes[index].code.toString(),
                                    groupId,
                                  );
                                },
                                text: "حذف",
                                width: 100,
                                textColor: Colors.white,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    ).isLogin();
  }
}
