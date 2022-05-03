import 'dart:convert';
import 'package:chart_ganga/configs/app_routes.dart';
import 'package:chart_ganga/constants/api_paths.dart';
import 'package:chart_ganga/models/user_model.dart';
import 'package:chart_ganga/modules/auth/services/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  Future<UserModel> registerService({required UserModel userModel}) async {
    try {
      print(userModel.toJsonForRegistration());
      var url = Uri.parse(ApiPaths.registerUrl);
      var res = await http
          .post(
            url,
            body: userModel.toJsonForRegistration(),
          )
          .timeout(const Duration(seconds: 10));
      print(res.statusCode);
      if (res.statusCode == 200) {
        UserModel data = UserModel.fromJsonForTokens(map: jsonDecode(res.body));
        return data;
      } else if (res.statusCode == 406) {
        return Future.error(jsonDecode(res.body)["detail"]);
      } else {
        print(res.body);
        return Future.error("User Registration Failed!");
      }
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<UserModel> loginService({required UserModel userModel}) async {
    try {
      var url = Uri.parse(ApiPaths.loginUrl);
      var res = await http
          .post(
            url,
            body: userModel.toJsonForLogin(),
          )
          .timeout(const Duration(seconds: 10));
      if (res.statusCode == 200) {
        UserModel data = UserModel.fromJsonForTokens(map: jsonDecode(res.body));
        return data;
      } else {
        return Future.error("User Authentication Failed!");
      }
    } catch (e) {
      return Future.error('User Authentication Failed!');
    }
  }

  Future<bool> autoAuthenticationAttempt() async {
    try {
      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getLocalToken();
      if (token != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future logout(BuildContext context) async {
    await SecureStorage().deleteLocalToken();
    Navigator.pushNamed(context, SPLASH_ROUTE);
  }

  Future<UserModel> getUser() async {
    try {
      var dio = Dio();

      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getLocalToken();

      if (token != null) {
        var response = await dio.get(ApiPaths.getUser,
            options: Options(headers: {"token": token}));
        print(response.statusCode);
        if (response.statusCode == 200) {
          UserModel user = UserModel.fromJsonForGetUser(map: response.data);
          return user;
        } else {
          return Future.error("Failed trying to get user!");
        }
      } else {
        return Future.error("Failed trying to get user!");
      }
    } catch (e) {
      print(e.toString());
      return Future.error('Failed trying to get user!');
    }
  }
}
