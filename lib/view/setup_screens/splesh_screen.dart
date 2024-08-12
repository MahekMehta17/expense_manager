import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wear_ai/utils/app_colors.dart';
import 'package:wear_ai/utils/image_path.dart';

import '../../controller/splash_screen_controller.dart';
import '../../utils/image_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashScreenController splashScreenController = Get.put(SplashScreenController());

  @override
  void initState() {
    super.initState();
    splashScreenController.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Container(color: AppColors.primaryColor, height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 68),
                child: Image.asset(ImagePath.logo, fit: BoxFit.fitWidth),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 120),
            //   child: Image.asset(
            //     ImagePath.transparentLogo,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
