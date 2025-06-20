import 'dart:convert';
import 'package:app_simasoft/core/route/route.dart';
import 'package:app_simasoft/core/utils/my_strings.dart';
import 'package:app_simasoft/data/model/User/user.model.dart';
import 'package:app_simasoft/data/model/auth/login_response_model.dart';
import 'package:app_simasoft/data/model/response_model/response_model.dart';
import 'package:app_simasoft/data/repository/login_repo.dart';
import 'package:app_simasoft/presentation/widgets/snack_bar/show_custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginRepo loginRepo;
  LoginController({required this.loginRepo});

  final FocusNode mobileNumberFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;

  List<String> errors = [];
  bool remember = false;

  void forgetPassword() {
    Get.toNamed(RouteHelper.forgotPasswordScreen);
  }

  bool isSubmitLoading = false;
  void loginUser() async {
    isSubmitLoading = true;
    update();

    ResponseModel model = await loginRepo.loginUser(
      emailController.text.toString(),
      passwordController.text.toString(),
    );


    if (model.statusCode == 200 || model.statusCode == 201) {
      LoginResponseModel loginModel = LoginResponseModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (loginModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {

        String accessToken = loginModel.data?.accessToken ?? "";
        String tokenType = loginModel.data?.tokenType ?? "";
        User? user = loginModel.data?.user;

        await RouteHelper.checkUserStatusAndGoToNextStep(
          user,
          accessToken: accessToken,
          tokenType: tokenType,
        );
      } else {
        CustomSnackBar.error(
          errorList: loginModel.message ?? MyStrings.loginFailedTryAgain,
        );
      }
    } else {
      CustomSnackBar.error(errorList: model.message);
    }

    isSubmitLoading = false;
    update();
  }



  void clearTextField() {
    passwordController.text = '';
    emailController.text = '';
    update();
  }
}
