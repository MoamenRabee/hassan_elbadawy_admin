import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:hassan_elbadawy_admin/models/notification_model.dart';

Future<void> sendFCM({
  required String topic,
  required String title,
  required String body,
}) async {
  NotificationModel notificationModel = NotificationModel(
    id: null,
    topic: topic,
    title: title,
    body: body,
    dateTime: DateTime.now(),
  );

  var result = await FirebaseFirestore.instance
      .collection("Notifications")
      .add(notificationModel.toMap());
  await result.update({"id": result.id});

  BaseOptions options = BaseOptions(
    baseUrl: "https://fcm.googleapis.com/",
    headers: {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAAqcgDC3s:APA91bGDKnyMqnHQIM5vu8N0SdM6_1pE_hJD1dd4AYMvPVWplC9SNZ2IdrymQEQxyjfchoL3H6XasO-5MMWGb1EOhNvFQjBLfsVVW-RAy_kw_u89jGF6y5VqDsIizi3ZLP5arR1sTQIP"
    },
  );

  Map<String, dynamic> data = {
    "to": "/topics/$topic",
    "notification": {
      "title": title,
      "body": body,
      "visibility": "PUBLIC",
    },
    "priority": "high"
  };

  Dio dio = Dio(options);

  try {
    var result = await dio.post("fcm/send", data: data);

    log("FCM SENT : $result");
    log("FCM TOPIC : $topic");
  } catch (e) {
    log("ERROR FCM : $e");
  }
}
