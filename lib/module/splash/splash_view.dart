
import 'dart:async';

import 'package:evently_app_c13_sun_7_pm/core/constant/app_constant.dart';
import 'package:evently_app_c13_sun_7_pm/core/routes/pages_routes_name.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
   SplashView({super.key});


  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(  const Duration(seconds: 2),(){
     Navigator.pushNamedAndRemoveUntil(context, RoutesName.onBoradingView,(route) => false);
    });
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image.asset(AppConstant.evently_icon,
            height: size.height*.22,
            ),

          ],
        ),
      ),
    );
  }
}
