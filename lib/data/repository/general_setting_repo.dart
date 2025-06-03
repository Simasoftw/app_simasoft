

import 'package:app_simasoft/core/helper/shared_preference_helper.dart';
import 'package:app_simasoft/core/utils/method.dart';
import 'package:app_simasoft/core/utils/url_container.dart';
import 'package:app_simasoft/data/model/response_model/response_model.dart';
import 'package:app_simasoft/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralSettingRepo {
  ApiClient apiClient;
  GeneralSettingRepo({required this.apiClient});

  Future<dynamic> validateSession() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? token = sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
    print("token ${token}");

    if (token == null || token.isEmpty) {
      return ResponseModel(
        false,
        "Token vacío",
        400,
        "",
      );
    }

    String url = '${UrlContainer.baseUrl}${UrlContainer.validateToken}';
    ResponseModel response = await apiClient.request(url, Method.postMethod, {"token": token}, passHeader: false);
    print("object ${response}");
    return response;
  }

}
