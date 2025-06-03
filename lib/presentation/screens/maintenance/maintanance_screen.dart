import 'package:app_simasoft/core/utils/dimensions.dart';
import 'package:app_simasoft/core/utils/my_animation.dart';
import 'package:app_simasoft/core/utils/my_color.dart';
import 'package:app_simasoft/core/utils/my_strings.dart';
import 'package:app_simasoft/core/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';


class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: 'maintenance',
      child: Scaffold(
        backgroundColor: MyColor.colorWhite,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Lottie.asset(MyAnimation.maintenance),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.space10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(MyStrings.maintenanceTitle.tr,
                        style: boldExtraLarge.copyWith(
                            color: MyColor.primaryColor)),
                    SizedBox(height: Dimensions.space5),
                    Text(
                      MyStrings.maintenanceSubtitle.tr,
                      style: regularDefault.copyWith(color: MyColor.colorGrey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



class WillPopWidget extends StatelessWidget {
  final Widget child;
  final String nextRoute;

  const WillPopWidget({super.key, required this.child, this.nextRoute = ''});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (nextRoute.isEmpty) {
          Get.defaultDialog(
            title: '¿Salir de la app?',
            middleText: '¿Estás seguro de que quieres salir?',
            textCancel: 'Cancelar',
            textConfirm: 'Salir',
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.back(); // Cierra el diálogo
              Future.delayed(const Duration(milliseconds: 100), () {
                // Cierra la app
                Get.back(); // Salir del contexto actual (WillPopScope)
              });
            },
          );
          return false;
        } else {
          Get.offAllNamed(nextRoute);
          return false;
        }
      },
      child: child,
    );
  }
}
