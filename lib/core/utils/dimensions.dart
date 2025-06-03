import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dimensions {
  // Font sizes
  static double fontOverSmall = 8.sp;
  static double fontExtraSmall = 10.sp;
  static double fontSmall = 12.sp;
  static double fontDefault = 13.sp;
  static double fontMedium = 14.sp;
  static double fontLarge = 16.sp;
  static double fontExtraLarge = 19.sp;
  static double fontOverLarge = 20.sp;
  static double fontOverLarge2 = 21.sp;
  static double fontOverMega = 40.sp;
  static double widthFull = double.infinity;

  // Heights and margins
  static double defaultButtonH = 45.h;
  static double cardMargin = 12.w;

  // Radius
  static double buttonRadius = 4.r;
  static double cardRadius = 8.r;
  static double cardMediumRadius = 16.r;
  static double bottomSheetRadius = 15.r;
  static double defaultRadius = 4.r;
  static double mediumRadius = 8.r;
  static double largeRadius = 12.r;
  static double extraRadius = 16.r;
  static double radiusHuge = 50.r;

  // Spacings
  static double textToTextSpace = 8.h;
  static double space1 = 1.w;
  static double space2 = 2.w;
  static double space3 = 3.w;
  static double space4 = 4.w;
  static double space5 = 5.w;
  static double space6 = 6.w;
  static double space7 = 7.w;
  static double space8 = 8.w;
  static double space10 = 10.w;
  static double space12 = 12.w;
  static double space15 = 15.w;
  static double space16 = 16.w;
  static double space17 = 17.w;
  static double space20 = 20.w;
  static double space25 = 25.w;
  static double space30 = 30.w;
  static double space35 = 35.w;
  static double space40 = 40.w;
  static double space45 = 45.w;
  static double space50 = 50.w;

  // Screen paddings
  static double screenPaddingH = 15.w;
  static double screenPaddingV = 15.h;

  // EdgeInsets adaptados
  static EdgeInsets screenPaddingHV =
  EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h);

  static EdgeInsets defaultPaddingHV =
  EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h);

  static EdgeInsets paddingInset = EdgeInsets.symmetric(
    horizontal: screenPaddingH,
    vertical: screenPaddingV * 4,
  );

  static EdgeInsets screenPaddingHV1 =
  EdgeInsets.symmetric(vertical: 20.h, horizontal: 17.w);

  static EdgeInsets previewPaddingHV =
  EdgeInsets.symmetric(vertical: 17.h, horizontal: 15.w);

  static EdgeInsets screenPadding =
  EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h);
}
