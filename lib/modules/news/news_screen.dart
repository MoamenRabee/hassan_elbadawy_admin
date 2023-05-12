import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hassan_elbadawy_admin/functions/validate_auth.dart';
import 'package:hassan_elbadawy_admin/modules/news/cubit/news_cubit.dart';
import 'package:hassan_elbadawy_admin/modules/news/form_news_screen.dart';

import '../../routes/routes.dart';
import '../../theme/theme.dart';
import '../../widgets/buttons.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NewsCubit cubit = NewsCubit.get(context);
    cubit.allNews = [];
    cubit.getNews();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.go(Paths.HOME);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("الأخبار"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return FormNewsScreen(
                          action: "add",
                        );
                      });
                },
                text: "اضافة خبر",
                width: 200,
                color: Colors.white,
                textColor: MyColors.mainColor,
              ),
            ),
          ],
        ),
        body: BlocConsumer<NewsCubit, NewsState>(
          listener: (context, state) {},
          builder: (context, state) {
            return cubit.isLoadingGetNews
                ? const Center(
                    child: CircularProgressIndicator(
                      color: MyColors.mainColor,
                    ),
                  )
                : cubit.allNews.isEmpty
                    ? const Center(
                        child: Text("لا يوجد آخبار"),
                      )
                    : ListView.builder(
                        itemCount: cubit.allNews.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.book),
                            title: Text(
                              cubit.allNews[index].title.toString(),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  cubit.isLoadingAction
                                      ? const CircularProgressIndicator()
                                      : CustomButton(
                                          onPressed: () async {
                                            await cubit.deleteNews(
                                              cubit.allNews[index].id
                                                  .toString(),
                                            );
                                          },
                                          text: "حذف",
                                          width: 100,
                                          textColor: Colors.white,
                                          color: Colors.red,
                                        ),
                                  const SizedBox(width: 10),
                                  CustomButton(
                                    onPressed: () async {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return FormNewsScreen(
                                              action: "edit",
                                              newsModel: cubit.allNews[index],
                                            );
                                          });
                                    },
                                    text: "تعديل",
                                    width: 100,
                                    textColor: Colors.white,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
          },
        ),
      ),
    ).isLogin();
  }
}
