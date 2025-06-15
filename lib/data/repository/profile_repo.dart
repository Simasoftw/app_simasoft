import 'package:app_simasoft/data/model/response_model/response_model.dart';
import 'package:app_simasoft/core/helper/shared_preference_helper.dart';
import 'package:app_simasoft/data/services/api_service.dart';

class ProfileRepo {
  ApiClient apiClient;

  ProfileRepo({required this.apiClient});


  Future<ResponseModel> logout() async {

    await clearSharedPrefData();

    ResponseModel responseModel = ResponseModel(
      true,
      "hola",
      200,
      '{"data":"ok"}',
    );


    return responseModel;
  }

  Future<void> clearSharedPrefData() async {
    await apiClient.sharedPreferences
        .setString(SharedPreferenceHelper.userNameKey, '');
    await apiClient.sharedPreferences
        .setString(SharedPreferenceHelper.userEmailKey, '');
    await apiClient.sharedPreferences
        .setString(SharedPreferenceHelper.accessTokenType, '');
    await apiClient.sharedPreferences
        .setString(SharedPreferenceHelper.accessTokenKey, '');
    await apiClient.sharedPreferences
        .setBool(SharedPreferenceHelper.rememberMeKey, false);
    return Future.value();
  }
}
