import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';
import 'my_color.dart';

class MyUtils {
  static void vibrate() async {
    print('vibrate');
    // if (await Vibration.hasVibrator() ?? false) {
    Vibration.vibrate(duration: 1000);
    HapticFeedback.heavyImpact();
    // }
  }

  static splashScreen() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyColor.getPrimaryColor(),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: MyColor.getPrimaryColor(),
        systemNavigationBarIconBrightness: Brightness.light));
  }

  static allScreen() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyColor.getPrimaryColor(),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: MyColor.colorWhite,
        systemNavigationBarIconBrightness: Brightness.dark));
  }

  static dynamic getShadow() {
    return [
      BoxShadow(
          blurRadius: 15.0,
          offset: const Offset(0, 25),
          color: Colors.grey.shade500.withValues(alpha: 0.6),
          spreadRadius: -35.0),
    ];
  }



  static dynamic getBottomSheetShadow() {
    return [
      BoxShadow(
        color: Colors.grey.shade400.withValues(alpha: 0.08),
        spreadRadius: 3,
        blurRadius: 4,
        offset: const Offset(0, 3),
      ),
    ];
  }

  static dynamic getShadow2({double blurRadius = 8}) {
    return [
      BoxShadow(
        color: MyColor.getShadowColor().withValues(alpha: 0.3),
        blurRadius: blurRadius,
        spreadRadius: 3,
        offset: const Offset(0, 10),
      ),
      BoxShadow(
        color: MyColor.getShadowColor().withValues(alpha: 0.3),
        spreadRadius: 1,
        blurRadius: blurRadius,
        offset: const Offset(0, 1),
      ),
    ];
  }

  static dynamic getCardShadow() {
    return [
      BoxShadow(
        color: Colors.grey.shade400.withValues(alpha: 0.05),
        spreadRadius: 2,
        blurRadius: 2,
        offset: const Offset(0, 3),
      ),
    ];
  }

  static Future<void> launchPhone(url) async {
    await launchUrl(Uri.parse("tel:$url"));
  }

  static dynamic getCardTopShadow() {
    return [
      BoxShadow(
        color: Colors.grey.shade400.withValues(alpha: 0.05),
        offset: const Offset(0, 0),
        blurRadius: 20,
        spreadRadius: 0,
      ),
    ];
  }

  static dynamic getBottomNavShadow() {
    return [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.15),
        blurRadius: 20,
        spreadRadius: 0,
        offset: const Offset(0, 0),
      ),
    ];
  }



  static String maskSensitiveInformation(String input) {
    try {
      if (input.isEmpty) {
        return '';
      }

      final int maskLength = input.length ~/ 2;

      final String mask = '*' * maskLength;

      final String maskedInput = maskLength > 4
          ? input.replaceRange(5, maskLength, mask)
          : input.replaceRange(0, maskLength, mask);

      return maskedInput;
    } catch (e) {
      return input;
    }
  }

  void stopLandscape() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }



  static bool isImage(String path) {
    if (path.contains('.jpg')) {
      return true;
    }
    if (path.contains('.png')) {
      return true;
    }
    if (path.contains('.jpeg')) {
      return true;
    }
    return false;
  }

  static bool isDoc(String path) {
    if (path.contains('.doc')) {
      return true;
    }
    if (path.contains('.docs')) {
      return true;
    }
    return false;
  }

  static String maskEmail(String email) {
    try {
      if (email.isEmpty) {
        return '';
      }

      List<String> parts = email.split('@');
      String maskedPart = maskString(parts[0]);

      if (parts.length > 2) {
        return "$maskedPart@${parts[1]}";
      } else {
        return "$maskedPart@${parts[1]}";
      }
    } catch (e) {
      return email;
    }
  }

  static String maskString(String str) {
    if (str.length <= 2) {
      return str.substring(0, 1) + "*" * (str.length - 1);
    } else {
      return str.substring(0, 1) +
          "*" * (str.length - 2) +
          str.substring(str.length - 1);
    }
  }

  static Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
