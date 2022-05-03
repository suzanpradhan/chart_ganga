import 'package:dio/dio.dart';

import '../../../constants/api_paths.dart';
import '../../auth/services/secure_storage.dart';

class WithdrawRepo {
  Future<String> withdraw(
      {required String amount,
      required String id,
      required bool isPatym}) async {
    try {
      var dio = Dio();
      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getLocalToken();

      if (token != null) {
        var response = await dio.post(ApiPaths.withdrawUrl,
            data: isPatym
                ? {
                    "amount": double.parse(amount),
                    "platform_type": 1,
                    "phonenumber": id
                  }
                : {
                    "amount": double.parse(amount),
                    "platform_type": 2,
                    "upi_id": id
                  },
            options: Options(headers: {"token": token}));
        print(response.statusCode);
        if (response.statusCode == 200) {
          return response.data["message"];
        } else {
          // print(res.body);
          return Future.error("Withdraw Failed!");
        }
      } else {
        return Future.error("Withdraw Failed!");
      }
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }
}
