import 'dart:convert';

import 'package:app_simasoft/core/helper/shared_preference_helper.dart';
import 'package:app_simasoft/core/utils/method.dart';
import 'package:app_simasoft/core/utils/my_strings.dart';
import 'package:app_simasoft/core/utils/url_container.dart';
import 'package:app_simasoft/data/model/authorization/email_verification_model.dart';
import 'package:app_simasoft/data/model/response_model/response_model.dart';
import 'package:app_simasoft/data/services/api_service.dart';
import 'package:app_simasoft/presentation/widgets/snack_bar/show_custom_snackbar.dart';
import 'package:http/http.dart' as http;

class LoginRepo {
  ApiClient apiClient;

  LoginRepo({required this.apiClient});

  Future<ResponseModel> loginUser(String email, String password) async {
    Map<String, String> map = {'email': email, 'password': password};
    String url = 'http://192.168.1.17:3000/api/client/login-client';

    ResponseModel model =
        await apiClient.request(url, Method.postMethod, map, passHeader: false);
    return model;
  }

  Future<String> forgetPassword(String type, String value) async {
    final map = modelToMap(value, type);
    String url =
        '${UrlContainer.baseUrl}${UrlContainer.forgetPasswordEndPoint}';
    final response = await apiClient.request(url, Method.postMethod, map,
        isOnlyAcceptType: true, passHeader: true);

    EmailVerificationModel model =
        EmailVerificationModel.fromJson(jsonDecode(response.responseJson));

    if (model.status.toLowerCase() == "success") {
      apiClient.sharedPreferences.setString(
          SharedPreferenceHelper.userEmailKey, model.data?.email ?? '');
      CustomSnackBar.success(successList:
        '${MyStrings.passwordResetEmailSentTo} ${model.data?.email ?? MyStrings.yourEmail}'
      );
      return model.data?.email ?? '';
    } else {
      CustomSnackBar.error(errorList: model.message);
      return '';
    }
  }

  Map<String, String> modelToMap(String value, String type) {
    Map<String, String> map = {'type': type, 'value': value};
    return map;
  }

  Future<EmailVerificationModel> verifyForgetPassCode(String code) async {
    String? email = apiClient.sharedPreferences
            .getString(SharedPreferenceHelper.userEmailKey) ??
        '';
    Map<String, String> map = {'code': code, 'email': email};

    String url =
        '${UrlContainer.baseUrl}${UrlContainer.passwordVerifyEndPoint}';

    final response = await apiClient.request(url, Method.postMethod, map,
        passHeader: true, isOnlyAcceptType: true);

    EmailVerificationModel model =
        EmailVerificationModel.fromJson(jsonDecode(response.responseJson));
    if (model.status == 'success') {
      model.setCode(200);
      return model;
    } else {
      model.setCode(400);
      return model;
    }
  }

  Future<EmailVerificationModel> resetPassword(
      String email, String password, String code) async {
    Map<String, String> map = {
      'token': code,
      'email': email,
      'password': password,
      'password_confirmation': password,
    };

    Uri url = Uri.parse(
        '${UrlContainer.baseUrl}${UrlContainer.resetPasswordEndPoint}');

    final response = await http.post(url, body: map, headers: {
      "Accept": "application/json",
      "dev-token":
          "\$2y\$12\$mEVBW3QASB5HMBv8igls3ejh6zw2A0Xb480HWAmYq6BY9xEifyBjG",
    });
    EmailVerificationModel model =
        EmailVerificationModel.fromJson(jsonDecode(response.body));

    if (model.status == 'success') {
      CustomSnackBar.success(successList: model.message.toString());
      model.setCode(200);
      return model;
    } else {
      CustomSnackBar.error(errorList: model.message ?? "Ha ocurrido un error");
      model.setCode(400);
      return model;
    }
  }


}
