import 'dart:convert';

import 'package:chart_ganga/constants/api_paths.dart';
import 'package:chart_ganga/modules/auth/services/secure_storage.dart';
import 'package:chart_ganga/modules/home/models/category_model.dart';
import 'package:chart_ganga/modules/posts/models/post_model.dart';
import 'package:dio/dio.dart';

class CategoryRepo {
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      var dio = Dio();
      var response = await dio.get(
        ApiPaths.getAllCategoryUrl,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<CategoryModel> dataMappedToModel = (response.data as List)
            .map((data) => CategoryModel.fromJson(map: data))
            .toList();
        return dataMappedToModel;
      } else {
        return Future.error("Failed to load category.");
      }
    } catch (e) {
      print(e.toString());
      return Future.error('Failed to load category.');
    }
  }
}
