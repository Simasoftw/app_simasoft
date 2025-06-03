import 'package:app_simasoft/core/utils/dimensions.dart';
import 'package:app_simasoft/core/utils/my_color.dart';
import 'package:app_simasoft/core/utils/my_strings.dart';
import 'package:app_simasoft/core/utils/style.dart';
import 'package:app_simasoft/presentation/widgets/button/rounded_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

showExitDialog(BuildContext context) {
  AwesomeDialog(
    padding:  EdgeInsets.symmetric(vertical: Dimensions.space10),
    context: context,
    dialogType: DialogType.noHeader,
    dialogBackgroundColor: MyColor.getCardBgColor(),
    width: MediaQuery.of(context).size.width,
    buttonsBorderRadius: BorderRadius.circular(Dimensions.defaultRadius),
    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: true,
    onDismissCallback: (type) {},
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: MyStrings.exitTitle.tr,
    titleTextStyle: regularLarge.copyWith(
        color: MyColor.colorBlack, fontWeight: FontWeight.w600),
    showCloseIcon: false,
    btnCancel: RoundedButton(
      text: MyStrings.no.tr,
      press: () {
        Navigator.pop(context);
      },
      horizontalPadding: 3,
      verticalPadding: 3,
      color: MyColor.getHintTextColor(),
    ),
    btnOk: RoundedButton(
        text: MyStrings.yes.tr,
        press: () {
          SystemNavigator.pop();
        },
        horizontalPadding: 3,
        verticalPadding: 3,
        color: MyColor.colorRed,
        textColor: MyColor.colorWhite),
    btnCancelOnPress: () {},
    btnOkOnPress: () {
      SystemNavigator.pop();
    },
  ).show();
}
