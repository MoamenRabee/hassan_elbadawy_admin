import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassan_elbadawy_admin/models/news_model.dart';
import 'package:meta/meta.dart';

import '../../../functions/fcm.dart';
import '../../../functions/uploud_file.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(BuildContext context) => BlocProvider.of(context);

  bool isLoading = false;
  bool isLoadingGetNews = false;
  bool isLoadingAction = false;
  bool isLoadingActionUpdate = false;

  Uint8List? selectedImage;
  String? imageExt;

  void selectNewsImage() async {
    final selectedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    selectedImage = selectedFile?.files.single.bytes;
    imageExt = selectedFile?.files.single.extension;
    if (selectedImage == null) {
      return;
    }
    emit(SelectImageState());
  }

  void removeImage() {
    selectedImage = null;
    emit(SelectImageState());
  }

  Future<void> addNews({
    required String title,
    required String videoUrl,
    required String content,
  }) async {
    isLoading = true;

    emit(AddNewsLoading());

    try {
      NewsModel newsModel = NewsModel(
        id: null,
        title: title,
        image: selectedImage == null
            ? ""
            : await uploadFile(
                refName: "NEWS",
                bytes: selectedImage!,
                fileExtension: imageExt!),
        videoUrl: videoUrl,
        content: content,
        date: DateTime.now(),
      );

      DocumentReference<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection("News")
          .add(newsModel.toMap());
      await result.update({"id": result.id});

      selectedImage = null;
      imageExt = null;

      await sendFCM(topic: "news", title: "خبر جديد", body: title);

      await getNews();
      isLoading = false;
      emit(AddNewsSuccess());
    } catch (e) {
      log("$e");
      isLoading = false;
      emit(AddNewsError());
    }
  }

  Future<void> editNews({
    required NewsModel oldNewsModel,
    required String title,
    required String videoUrl,
    required String content,
  }) async {
    isLoadingActionUpdate = true;

    emit(EditNewsLoading());

    try {
      NewsModel newsModel = NewsModel(
        id: oldNewsModel.id,
        title: title,
        image: selectedImage == null
            ? oldNewsModel.image
            : await uploadFile(
                refName: "NEWS",
                bytes: selectedImage!,
                fileExtension: imageExt!),
        videoUrl: videoUrl,
        content: content,
        date: oldNewsModel.date,
      );

      await FirebaseFirestore.instance
          .collection("News")
          .doc(oldNewsModel.id)
          .update(newsModel.toMap());

      selectedImage = null;
      imageExt = null;

      await getNews();
      isLoadingActionUpdate = false;
      emit(EditNewsSuccess());
    } catch (e) {
      log("$e");
      isLoadingActionUpdate = false;
      emit(EditNewsError());
    }
  }

  List<NewsModel> allNews = [];
  Future<void> getNews() async {
    allNews.clear();
    isLoadingGetNews = true;
    emit(GetNewsLoading());
    try {
      QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
          .instance
          .collection("News")
          .orderBy("date", descending: true)
          .get();

      for (var element in result.docs) {
        allNews.add(NewsModel.fromJson(element.data()));
      }

      isLoadingGetNews = false;
      emit(GetNewsSuccess());
    } catch (e) {
      log("$e");
      isLoadingGetNews = false;
      emit(GetNewsError());
    }
  }

  Future<void> deleteNews(String id) async {
    isLoadingAction = true;
    emit(DeleteNewsLoading());
    try {
      await FirebaseFirestore.instance.collection("News").doc(id).delete();
      await getNews();
      isLoadingAction = false;
      emit(DeleteNewsSuccess());
    } catch (e) {
      isLoadingAction = false;
      emit(DeleteNewsError());
    }
  }
}
