import 'dart:io';

import 'package:dio/dio.dart';

class AddNewPostModel {
  final File? image;
  final String? title;
  final int? categoryId;
  final String? content;

  AddNewPostModel({this.image, this.categoryId, this.content, this.title});

  Future<Map<String, dynamic>> toJson() async {
    return {
      "title": title,
      "content": content ?? "",
      "cover_image": (image != null)
          ? await MultipartFile.fromFile(image!.path, filename: image!.path)
          : null,
      "category_id": categoryId
    };
  }
}
