import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:path/path.dart';

Future<String> uploadFile(
    {required String refName,
    required Uint8List bytes,
    required String fileExtension}) async {
  String fileName = Random().nextInt(1000000).toString();
  String downloadURL = "";

  // try {
  //   final storage = FirebaseStorage.instance;

  //   Uint8List bytes = await file.readAsBytes();

  //   Reference ref = storage.ref(refName).child('${DateTime.now()}.${extension(file.path)}');
  //   UploadTask uploadTask =
  //       ref.putData(bytes);
  //   TaskSnapshot taskSnapshot = await uploadTask
  //       .whenComplete(() => dev.log('done upload image'))
  //       .catchError((error) => dev.log('something went wrong'));
  //   String url = await taskSnapshot.ref.getDownloadURL();
  //   dev.log(url);
  //   downloadURL = url;
  // } catch (e) {
  //   dev.log(e.toString());
  // }

  try {
    final storage = FirebaseStorage.instance;

    Reference ref =
        storage.ref(refName).child('${DateTime.now()}.$fileExtension');
    UploadTask uploadTask = ref.putData(bytes);
    TaskSnapshot taskSnapshot = await uploadTask
        .whenComplete(() => dev.log('done upload image'))
        .catchError((error) => dev.log('something went wrong'));
    String url = await taskSnapshot.ref.getDownloadURL();
    dev.log(url);
    downloadURL = url;
  } catch (e) {
    dev.log(e.toString());
  }

  return downloadURL;
}

String base64Encode(List<int> bytes) => base64.encode(bytes);
