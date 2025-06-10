import 'package:app_simasoft/data/controllers/loan/loan_controller.dart';
import 'package:app_simasoft/data/controllers/user/user_controller.dart';
import 'package:app_simasoft/data/repository/loan_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'core/di_service/di_services.dart' as di_service;
import 'core/route/route.dart';
import 'core/theme/light/light.dart';
import 'core/utils/util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di_service.init();
  MyUtils.allScreen();
  MyUtils().stopLandscape();
  Get.put(LoanRepo(apiClient: Get.find()));

  Get.put(LoanController(loanRepo: Get.find()));
  Get.put<UserController>(UserController(), permanent: true); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lightThemeData,
          initialRoute: RouteHelper.splashScreen,
          getPages: RouteHelper().routes,
        );
      },
    );
  }
}