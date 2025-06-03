import 'dart:convert';
import 'package:app_simasoft/core/helper/shared_preference_helper.dart';
import 'package:app_simasoft/core/route/route.dart';
import 'package:app_simasoft/core/utils/my_strings.dart' show MyStrings;
import 'package:app_simasoft/data/model/general_setting_response_model.dart';
import 'package:app_simasoft/data/model/response_model/response_model.dart';
import 'package:app_simasoft/data/repository/splash/splash_repo.dart';
import 'package:app_simasoft/presentation/widgets/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  SplashRepo repo;
  SplashController({required this.repo});

  bool isLoading = true;
  gotoNextPage() async {
    noInternet = false;
    update();
    getGSData();
  }

  bool noInternet = false;
  void getGSData() async {
    isLoading = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey) ?? "";

    ResponseModel response = await repo.validateSession(token);


    if (response.statusCode == 200) {
      GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(
          jsonDecode(response.responseJson)
      );

      isLoading = false;
      update();
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAndToNamed(RouteHelper.homeScreen);
      });

    } else {
      isLoading = false;
      update();
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAndToNamed(RouteHelper.loginScreen);
      });
    }
    if (response.statusCode == 503) {
      noInternet = true;
      update();
    }
    CustomSnackBar.error(errorList: response.message);
  }
}
