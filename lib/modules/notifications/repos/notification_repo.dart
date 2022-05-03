import 'dart:convert';

import 'package:chart_ganga/constants/api_paths.dart';
import 'package:chart_ganga/modules/auth/services/secure_storage.dart';
import 'package:chart_ganga/modules/new_post/models/add_new_post_model.dart';
import 'package:chart_ganga/modules/notifications/models/notification_model.dart';
import 'package:chart_ganga/modules/posts/models/post_model.dart';
import 'package:dio/dio.dart';

class NotificationRepo {
  Future<List<NotificationModel>> getMyNotifications() async {
    try {
      var dio = Dio();

      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getLocalToken();

      if (token != null) {
        var response = await dio.get(ApiPaths.getMyNotificationsUrl,
            options: Options(headers: {"token": token}));
        print(response.statusCode);
        if (response.statusCode == 200) {
          List<NotificationModel> dataMappedToModel = (response.data as List)
              .map((data) => NotificationModel.fromJson(map: data))
              .toList();
          return dataMappedToModel;
        } else {
          return Future.error("Failed to load notifications.");
        }
      } else {
        return Future.error("Failed to load notifications.");
      }
    } catch (e) {
      print(e.toString());
      return Future.error('Failed to load notifications.');
    }
  }
}
