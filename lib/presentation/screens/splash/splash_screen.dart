import 'package:app_simasoft/core/utils/my_color.dart';
import 'package:app_simasoft/core/utils/my_images.dart';
import 'package:app_simasoft/core/utils/util.dart';
import 'package:app_simasoft/data/controllers/splash/splash_controller.dart';
import 'package:app_simasoft/data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../widgets/custom_no_data_found_class.dart';
import '../../widgets/loading.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    MyUtils.splashScreen();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    final controller = Get.put(
        SplashController(repo: Get.find(), )
    );

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.gotoNextPage();
    });
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyColor.screenBgColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: MyColor.transparentColor,
        systemNavigationBarIconBrightness: Brightness.dark));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<SplashController>(
        builder: (controller) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
              statusBarColor: MyColor.primaryColor,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light),
          child: Scaffold(
            backgroundColor: controller.noInternet
                ? MyColor.colorWhite
                : MyColor.primaryColor,
            body: controller.noInternet
                ? NoDataOrInternetScreen(
                    isNoInternet: true,
                    image: MyImages.noWifi,
                    onChanged: () {
                      controller.gotoNextPage();
                    },
                )
                : Stack(
                    children: [
                      CustomPreloader( ),
                      // Align(
                      //     alignment: Alignment.center,
                      //     child: Image.asset(MyImages.appLogoIcon,
                      //         height: 100, width: 100)),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
