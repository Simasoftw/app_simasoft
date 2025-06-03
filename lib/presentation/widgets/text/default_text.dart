import 'package:app_simasoft/core/utils/dimensions.dart';
import 'package:app_simasoft/core/utils/my_color.dart';
import 'package:app_simasoft/core/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DefaultText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  TextStyle? textStyle;
  final int maxLines;
  final Color? textColor;
  final double fontSize;

  DefaultText(
      {super.key,
      required this.text,
      this.textAlign,
      this.maxLines = 3,
      this.textStyle,
      this.textColor,
      this.fontSize = 13
      }
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontFamily: 'Inter',
          color: MyColor.primaryTextColor,
          fontWeight: FontWeight.w400,
          fontSize: Dimensions.fontDefault
      ),
      maxLines: maxLines,
    );
  }
}
