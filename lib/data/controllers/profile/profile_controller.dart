import 'package:app_simasoft/data/model/User/user.model.dart';
import 'package:app_simasoft/data/repository/profile_repo.dart';
import 'package:app_simasoft/presentation/widgets/snack_bar/show_custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:app_simasoft/core/route/route.dart';
import 'package:app_simasoft/core/utils/my_strings.dart';


class ProfileController extends GetxController {
  ProfileRepo profileRepo;
  User? model ;

  ProfileController({required this.profileRepo});

  String imageUrl = '';

  bool isLoading = true;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isSubmitLoading = false;
  void loadData(User? model) {

    firstNameController.text = model?.fullName ?? '';
    emailController.text = model!.email ?? "";

    isLoading = false;
    update();
  }


  final InAppReview inAppReview = InAppReview.instance;

  bool logoutLoading = false;
  Future<void> logout() async {
    logoutLoading = true;
    update();

    await profileRepo.logout();
    CustomSnackBar.success(successList: MyStrings.logoutSuccessMsg);

    logoutLoading = false;
    update();
    Get.offAllNamed(RouteHelper.loginScreen);
  }

}
