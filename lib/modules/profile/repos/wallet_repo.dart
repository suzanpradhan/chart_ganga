import 'package:chart_ganga/constants/api_paths.dart';
import 'package:chart_ganga/modules/auth/services/secure_storage.dart';
import 'package:chart_ganga/modules/profile/models/wallet_model.dart';
import 'package:dio/dio.dart';

class WalletRepo {
  Future<WalletModel> getWallet() async {
    try {
      var dio = Dio();

      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getLocalToken();

      if (token != null) {
        var response = await dio.get(ApiPaths.getWallet,
            options: Options(headers: {"token": token}));
        print(response.statusCode);
        print(response.data);
        if (response.statusCode == 200) {
          WalletModel wallet = WalletModel.fromJson(map: response.data);
          return wallet;
        } else {
          return Future.error("Failed trying to get wallet!");
        }
      } else {
        return Future.error("Failed trying to get wallet!");
      }
    } catch (e) {
      print(e.toString());
      return Future.error('Failed trying to get wallet!');
    }
  }
}
