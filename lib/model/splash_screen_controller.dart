import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/shared_preference.dart';
import '../utils/string_utils.dart';

class SplashScreenController extends GetxController {
  final SharedPreferenceClass sharedPreferenceClass = SharedPreferenceClass();

  void isLogin() async {
    String? token = await sharedPreferenceClass.retrieveData(StringUtils.isLogin);

    bool? isLogin = token == null ? false : true;

    if (isLogin) {
    } else {
      Timer(const Duration(seconds: 2), () {
        Get.off(() => LoginScreen());
      });
    }
  }
}
