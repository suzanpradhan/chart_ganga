import 'dart:io';

import 'package:dio/dio.dart';

class ProfileModel {
  final File? cover_image;
  final String? firstname;
  final String? lastname;
  final String? cover_image_url;

  ProfileModel(
      {this.cover_image, this.firstname, this.lastname, this.cover_image_url});

  Future<Map<String, dynamic>> toJson() async {
    return {
      "firstname": firstname,
      "lastname": lastname,
      "avatar": (cover_image != null)
          ? await MultipartFile.fromFile(cover_image!.path,
              filename: cover_image!.path)
          : null,
    };
  }

  factory ProfileModel.fromJson({required Map<String, dynamic> map}) {
    return ProfileModel(
        cover_image_url: map["avatar"],
        firstname: map["firstname"],
        lastname: map["lastname"]);
  }
}
