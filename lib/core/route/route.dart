import 'package:app_simasoft/core/helper/shared_preference_helper.dart';
import 'package:app_simasoft/data/model/User/user.model.dart';
import 'package:app_simasoft/presentation/screens/auth/forget_password/forget_password.dart';
import 'package:app_simasoft/presentation/screens/auth/login/login_screen.dart';
import 'package:app_simasoft/presentation/screens/home/home_screen.dart';
import 'package:app_simasoft/presentation/screens/image_preview/preview_image_screen.dart';
import 'package:app_simasoft/presentation/screens/maintenance/maintanance_screen.dart';
import 'package:app_simasoft/presentation/screens/profile/profile_screen.dart';
import 'package:app_simasoft/presentation/screens/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteHelper {
  static const String splashScreen = "/splash_screen";
  static const String loginScreen = "/login_screen";
  static const String forgotPasswordScreen = "/forget_password";
  static const String maintenanceScreen = '/maintenance_screen';
  static const String previewImageScreen = "/preview-image-screen";
  static const String homeScreen = "/home_screen";
  static const String profileScreen = "/profile_screen";

  List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: homeScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(
      name: previewImageScreen,
      page: () => PreviewImageScreen(url: Get.arguments),
    ),
    GetPage(name: maintenanceScreen, page: () => MaintenanceScreen()),
  ];

  static Future<void> checkUserStatusAndGoToNextStep(
    User? user, {
    String accessToken = "",
    String tokenType = "",
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(
      SharedPreferenceHelper.userEmailKey,
      user?.email ?? '',
    );

    await sharedPreferences.setString(
      SharedPreferenceHelper.userNameKey,
      user?.name ?? '',
    );

    if (accessToken.isNotEmpty) {
      await sharedPreferences.setString(
        SharedPreferenceHelper.accessTokenKey,
        accessToken,
      );
      await sharedPreferences.setString(
        SharedPreferenceHelper.accessTokenType,
        tokenType,
      );
    }

    Get.offAndToNamed(RouteHelper.homeScreen);

  }
}
