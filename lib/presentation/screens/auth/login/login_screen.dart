import 'package:app_simasoft/core/utils/dimensions.dart';
import 'package:app_simasoft/core/utils/my_color.dart';
import 'package:app_simasoft/core/utils/my_strings.dart';
import 'package:app_simasoft/core/utils/style.dart';
import 'package:app_simasoft/data/controllers/auth/login_controller.dart';
import 'package:app_simasoft/data/repository/login_repo.dart';
import 'package:app_simasoft/data/services/api_service.dart';
import 'package:app_simasoft/presentation/screens/maintenance/maintanance_screen.dart';
import 'package:app_simasoft/presentation/widgets/button/rounded_button.dart';
import 'package:app_simasoft/presentation/widgets/text-form-field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: Scaffold(
        backgroundColor: MyColor.colorWhite,
        body: GetBuilder<LoginController>(
          builder:
              (controller) => SingleChildScrollView(
                padding: Dimensions.screenPaddingHV,

                physics: const BouncingScrollPhysics(),
                child: SafeArea(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: Dimensions.space20),
                        Text(
                          'Inicia sesión',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Dimensions.space20),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                animatedLabel: true,
                                needOutlineBorder: true,
                                controller: controller.emailController,
                                labelText: MyStrings.usernameOrEmail,
                                onChanged: (value) {},
                                focusNode: controller.emailFocusNode,
                                nextFocus: controller.passwordFocusNode,
                                textInputType: TextInputType.emailAddress,
                                inputAction: TextInputAction.next,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Iconsax.sms_copy),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return MyStrings.fieldErrorMsg;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: Dimensions.space16),
                              CustomTextField(
                                animatedLabel: true,
                                needOutlineBorder: true,
                                labelText: MyStrings.password.tr,
                                controller: controller.passwordController,
                                focusNode: controller.passwordFocusNode,
                                onChanged: (value) {},
                                isShowSuffixIcon: true,
                                isPassword: true,
                                textInputType: TextInputType.text,
                                inputAction: TextInputAction.done,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Icon(Iconsax.lock_copy),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return MyStrings.fieldErrorMsg.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: Dimensions.space10),
                              Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                  onPressed: () {
                                    // Recuperar contraseña
                                  },
                                  child: Text(
                                    '¿Olvidaste tu contraseña?',
                                    style: boldMediumLarge,
                                  ),
                                ),
                              ),
                              SizedBox(height: Dimensions.space10),
                              RoundedButton(
                                isLoading: controller.isSubmitLoading,
                                text: MyStrings.signIn.tr,
                                press: () {
                                  if (_formKey.currentState!.validate()) {
                                    controller.loginUser();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
