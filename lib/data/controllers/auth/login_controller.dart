import 'dart:convert';
import 'package:app_simasoft/core/route/route.dart';
import 'package:app_simasoft/core/utils/my_strings.dart';
import 'package:app_simasoft/data/controllers/user/user_controller.dart';
import 'package:app_simasoft/data/model/User/user.model.dart';
import 'package:app_simasoft/data/model/auth/login_response_model.dart';
import 'package:app_simasoft/data/model/response_model/response_model.dart';
import 'package:app_simasoft/data/repository/login_repo.dart';
import 'package:app_simasoft/presentation/widgets/snack_bar/show_custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:app_simasoft/core/helper/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String nombreUsuario = "FRAYDER SIMARRA";
  String celular = "301 761 6855";
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

      final userController = Get.find<UserController>();

      if (loginModel.status.toString().toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        String accessToken = loginModel.data?.accessToken ?? "";
        String tokenType = loginModel.data?.tokenType ?? "";
        User? user = loginModel.data?.user;

        // ⬇️ Aquí guardas el usuario en el controlador global
        if (user != null) {  
          final prefs = await SharedPreferences.getInstance();
           String jsonUser = jsonEncode(user.toJson());
          await prefs.setString('user', jsonUser);
          userController.setUser(user);
        }

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

  Future<void> logoutUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Elimina solo los datos relacionados con el usuario
    await sharedPreferences.remove(SharedPreferenceHelper.userEmailKey);
    await sharedPreferences.remove(SharedPreferenceHelper.userNameKey);
    await sharedPreferences.remove(SharedPreferenceHelper.accessTokenKey);
    await sharedPreferences.remove(SharedPreferenceHelper.accessTokenType);

    // (Opcional) elimina otros datos si los tienes

    // Navega al login limpiando el historial de rutas
    Get.offAndToNamed(RouteHelper.loginScreen);
  }

  void clearTextField() {
    passwordController.text = '';
    emailController.text = '';
    update();
  }
}
