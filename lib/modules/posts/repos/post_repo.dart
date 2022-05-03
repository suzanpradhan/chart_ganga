import 'dart:convert';

import 'package:chart_ganga/constants/api_paths.dart';
import 'package:chart_ganga/modules/auth/services/secure_storage.dart';
import 'package:chart_ganga/modules/new_post/models/add_new_post_model.dart';
import 'package:chart_ganga/modules/posts/models/bookmark_model.dart';
import 'package:chart_ganga/modules/posts/models/post_model.dart';
import 'package:dio/dio.dart';

class PostRepo {
  Future<List<PostModel>> getTrendingPosts() async {
    try {
      var dio = Dio();

      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getLocalToken();

      var response = await dio.get(ApiPaths.getAllPostsUrl,
          options: Options(headers: {"token": token}));
      if (response.statusCode == 200) {
        print(response.data);
        List<PostModel> dataMappedToModel = (response.data as List)
            .map((data) => PostModel.fromJson(map: data))
            .toList();
        return dataMappedToModel;
      } else {
        return Future.error("Failed to load new feeds.");
      }
    } catch (e) {
      return Future.error('Failed to load new feeds.');
    }
  }

  Future<List<PostModel>> getPostsByCategory({required int category}) async {
    try {
      var dio = Dio();

      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getLocalToken();

      var response = await dio.get(ApiPaths.getAllPostsUrl,
          queryParameters: {"category_id": category},
          options: Options(headers: {"token": token}));
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<PostModel> dataMappedToModel = (response.data as List)
            .map((data) => PostModel.fromJson(map: data))
            .toList();
        return dataMappedToModel;
      } else {
        return Future.error("Failed to load new feeds.");
      }
    } catch (e) {
      print(e.toString());
      return Future.error('Failed to load new feeds.');
    }
  }

  Future<bool> createNewPost({required AddNewPostModel addNewPostModel}) async {
    try {
      var dio = Dio();

      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getLocalToken();

      if (token != null) {
        var formData = FormData.fromMap(await addNewPostModel.toJson());
        var response = await dio.post(ApiPaths.addNewPostUrl,
            data: formData, options: Options(headers: {"token": token}));
        print(response.statusCode);
        if (response.statusCode == 200) {
          return true;
        } else {
          // print(res.body);
          return Future.error("Failed trying to post!");
        }
      } else {
        return Future.error("Failed trying to post!");
      }
    } catch (e) {
      print(e.toString());
      return Future.error('Post Creation Failed!');
    }
  }

  Future<List<PostModel>> getMyPosts() async {
    try {
      var dio = Dio();

      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getLocalToken();

      var response = await dio.get(ApiPaths.getMyPosts,
          options: Options(headers: {"token": token}));
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<PostModel> dataMappedToModel = (response.data as List)
            .map((data) => PostModel.fromJson(map: data))
            .toList();
        return dataMappedToModel;
      } else {
        return Future.error("Failed to load my posts.");
      }
    } catch (e) {
      print(e.toString());
      return Future.error('Failed to load my posts.');
    }
  }

  Future<List<BookmarkModel>> getSavedPosts() async {
    try {
      var dio = Dio();

      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getLocalToken();

      var response = await dio.get(ApiPaths.getMySavedPosts,
          options: Options(headers: {"token": token}));
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<BookmarkModel> dataMappedToModel = (response.data as List)
            .map((data) => BookmarkModel.fromJson(map: data))
            .toList();
        return dataMappedToModel;
      } else {
        return Future.error("Failed to load my posts.");
      }
    } catch (e) {
      print(e.toString());
      return Future.error('Failed to load my posts.');
    }
  }

  Future<List<PostModel>> searchPosts({required String value}) async {
    try {
      var dio = Dio();

      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getLocalToken();

      var response = await dio.get(ApiPaths.searchPosts,
          queryParameters: {"search": value},
          options: Options(headers: {"token": token}));
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<PostModel> dataMappedToModel = (response.data as List)
            .map((data) => PostModel.fromJson(map: data))
            .toList();
        return dataMappedToModel;
      } else {
        return Future.error("Failed to load posts.");
      }
    } catch (e) {
      print(e.toString());
      return Future.error('Failed to load posts.');
    }
  }

  Future<PostModel> postVote(
      {required int voteType, required int postId}) async {
    try {
      var dio = Dio();

      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getLocalToken();

      if (token != null) {
        var response = await dio.post(ApiPaths.votePosts,
            data: {"post": postId, "vote_type": voteType},
            options: Options(headers: {"token": token}));
        print(response.statusCode);
        if (response.statusCode == 200) {
          PostModel postModel = PostModel.fromJson(map: response.data["data"]);
          return postModel;
        } else {
          // print(res.body);
          return Future.error("Failed trying to vote!");
        }
      } else {
        return Future.error("Failed trying to vote!");
      }
    } catch (e) {
      print(e.toString());
      return Future.error('Failed trying to vote!');
    }
  }

  Future<bool> bookmarkAttempt({required int postId}) async {
    try {
      var dio = Dio();

      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getLocalToken();

      if (token != null) {
        var response = await dio.post(ApiPaths.bookmarkUrl,
            data: {"post": postId},
            options: Options(headers: {"token": token}));
        print(response.statusCode);
        if (response.statusCode == 200) {
          return response.data["isBookmarked"];
        } else {
          // print(res.body);
          return Future.error("Failed trying to bookmark!");
        }
      } else {
        return Future.error("Failed trying to bookmark!");
      }
    } catch (e) {
      print(e.toString());
      return Future.error('Failed trying to bookmark!');
    }
  }
}
