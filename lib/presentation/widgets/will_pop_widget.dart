import 'package:app_simasoft/presentation/widgets/dialog/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WillPopWidget extends StatelessWidget {
  final Widget child;
  final String nextRoute;

  const WillPopWidget({super.key, required this.child, this.nextRoute = ''});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (nextRoute.isEmpty) {
            showExitDialog(context);
            return Future.value(false);
          } else {
            Get.offAllNamed(nextRoute);
            return Future.value(false);
          }
        },
        child: child);
  }
}
