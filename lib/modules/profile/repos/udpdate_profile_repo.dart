import 'package:chart_ganga/modules/profile/models/profile_model.dart';
import 'package:dio/dio.dart';

import '../../../constants/api_paths.dart';
import '../../auth/services/secure_storage.dart';

class UpdateProfileRepo {
  Future<ProfileModel> getProfile() async {
    try {
      var dio = Dio();

      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getLocalToken();

      if (token != null) {
        var response = await dio.get(ApiPaths.getProfileUrl,
            options: Options(headers: {"token": token}));
        print(response.statusCode);
        if (response.statusCode == 200) {
          return ProfileModel.fromJson(map: response.data);
        } else {
          // print(res.body);
          return Future.error("Failed to get profile!");
        }
      } else {
        return Future.error("Failed to get profile!");
      }
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<bool> updateProfile({required ProfileModel profileModel}) async {
    try {
      var dio = Dio();

      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getLocalToken();

      if (token != null) {
        var formData = FormData.fromMap(await profileModel.toJson());
        var response = await dio.put(ApiPaths.updateProfileUrl,
            data: formData, options: Options(headers: {"token": token}));
        print(response.statusCode);
        if (response.statusCode == 200) {
          return true;
        } else {
          // print(res.body);
          return Future.error("Failed to update profile!");
        }
      } else {
        return Future.error("Failed to update profile!");
      }
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }
}
