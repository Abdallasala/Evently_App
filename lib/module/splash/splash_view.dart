import 'dart:async';

import 'package:evently_app_c13_sun_7_pm/core/constant/app_constant.dart';
import 'package:evently_app_c13_sun_7_pm/core/routes/pages_routes_name.dart';
import 'package:evently_app_c13_sun_7_pm/core/services/shared_pref_helper.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkNavigation();
  }

  Future<void> _checkNavigation() async {
    // 1- Always display SplashView for 2 seconds first
    await Future.delayed(const Duration(seconds: 2));
    bool isFirst = await SharedPrefHelper.isFirstTime();

    if (!mounted) return;

    if (isFirst) {
      // First run ever: Splash (2 sec) -> Onboarding
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.onBoradingView,
        (route) => false,
      );
    } else {
      // Second run onwards: Splash (2 sec) -> Sign In
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.signIn,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppConstant.evently_icon,
              height: size.height * .22,
            ),
          ],
        ),
      ),
    );
  }
}
