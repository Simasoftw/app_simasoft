import 'dart:convert';
import 'dart:io';

import 'package:app_simasoft/core/helper/shared_preference_helper.dart';
import 'package:app_simasoft/core/route/route.dart';
import 'package:app_simasoft/core/utils/method.dart';
import 'package:app_simasoft/core/utils/my_strings.dart';
import 'package:app_simasoft/data/model/authorization/authorization_response_model.dart';
import 'package:app_simasoft/data/model/response_model/response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetxService {
  SharedPreferences sharedPreferences;
  ApiClient({required this.sharedPreferences});

  Future<ResponseModel> request(
    String uri,
    String method,
    Map<String, dynamic>? params, {
    bool passHeader = false,
    bool isOnlyAcceptType = false,
  }) async {
    Uri url = Uri.parse(uri);
    http.Response response;

    try {
      if (method == Method.postMethod) {
        if (passHeader) {
          initToken();
          Map<String, String> headers = {
            "Accept": "application/json",
            "Authorization": "$tokenType $token",
          };

          if (isOnlyAcceptType) {
            headers.remove("Authorization");
          }

          response = await http.post(
            url,
            body: params,
            headers: headers,
          );

          print("response service ${response.statusCode}");
        } else {
          response = await http.post(
            url,
            body: params,
            headers: {
              "dev-token":
              "\$2y\$12\$mEVBW3QASB5HMBv8igls3ejh6zw2A0Xb480HWAmYq6BY9xEifyBjG",
            },
          );
          print("response service ${response.statusCode}");
        }
      }
      else if (method == Method.deleteMethod) {
        response = await http.delete(url);
      } else if (method == Method.updateMethod) {
        response = await http.patch(url);
      } else {
        if (passHeader) {
          initToken();
          response = await http.get(
            url,
            headers: {
              "Accept": "application/json",
              "Authorization": "$tokenType $token",
            },
          );
        } else {
          response = await http.get(
            url,
            headers: {
              "Accept": "application/json",
            },
          );
        }
      }
      print("response service ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201 ) {

        final decodedResponse = jsonDecode(response.body);


        return ResponseModel(true, decodedResponse["message"], 200, response.body);
      } else if (response.statusCode == 401) {
        sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
        Get.offAllNamed(RouteHelper.loginScreen);
        return ResponseModel(
          false,
          MyStrings.unAuthorized.tr,
          401,
          response.body,
        );
      } else if (response.statusCode == 500) {
        return ResponseModel(
          false,
          MyStrings.serverError.tr,
          500,
          response.body,
        );
      } else {
        return ResponseModel(
          false,
          MyStrings.somethingWentWrong.tr,
          499,
          response.body,
        );
      }
    } on SocketException {
      return ResponseModel(false, MyStrings.noInternet.tr, 503, '');
    } on FormatException {
      return ResponseModel(false, MyStrings.badResponseMsg.tr, 400, '');
    } catch (e) {
      print("errrror ${e}");
      return ResponseModel(false, MyStrings.somethingWentWrong.tr, 499, '');
    }
  }

  String token = '';
  String tokenType = '';

  initToken() {
    if (sharedPreferences.containsKey(SharedPreferenceHelper.accessTokenKey)) {
      String? t = sharedPreferences.getString(
        SharedPreferenceHelper.accessTokenKey,
      );
      String? tType = sharedPreferences.getString(
        SharedPreferenceHelper.accessTokenType,
      );
      token = t ?? '';
      tokenType = tType ?? 'Bearer';
    } else {
      token = '';
      tokenType = 'Bearer';
    }
  }

  /*



  storeNotificationAudio(String notificationAudioPath) {
    sharedPreferences.setString(
        SharedPreferenceHelper.notificationAudioKey, notificationAudioPath);
  }

  String getNotificationAudio() {
    String pre = sharedPreferences
            .getString(SharedPreferenceHelper.notificationAudioKey) ??
        '';
    return pre;
  }



  bool isNotificationAudioEnable() {
    String pre = sharedPreferences
            .getString(SharedPreferenceHelper.notificationAudioEnableKey) ??
        '';
    return pre == '1' ? true : false;
  }

  storeNotificationAudioEnable(bool isEnable) {
    sharedPreferences.setString(
        SharedPreferenceHelper.notificationAudioEnableKey,
        isEnable ? '1' : '0');
  }
*/

  /*bool isGoogleLoginEnable() {
    String pre =
        sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ??
            '';
    GeneralSettingResponseModel model =
        GeneralSettingResponseModel.fromJson(jsonDecode(pre));
    bool enable = model.data?.generalSetting?.googleLogin == '1' ? true : false;
    return enable;
  }*/
}
