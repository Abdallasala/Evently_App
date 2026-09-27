
import 'package:evently_app_c13_sun_7_pm/core/routes/pages_routes_name.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/layout_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../module/forgetPassword/forget_password_view.dart';
import '../../module/onBording/on_bording_view.dart';
import '../../module/sign in/sign_in.dart';
import '../../module/signup/sign_up.dart';
import '../../module/splash/splash_view.dart';

abstract class AppRoutes {
  static Route onGenrateRoute (RouteSettings settings){
    switch(settings.name){
      case RoutesName.initial:
        return MaterialPageRoute(
            builder: ((context) =>  SplashView()),
          settings: settings
        );
      case RoutesName.onBoradingView:
        return MaterialPageRoute(
            builder: ((context) =>  OnBordingView()),
            settings: settings
        );
      case RoutesName.signIn:
        return MaterialPageRoute(
            builder: ((context) =>  SignIn()),
            settings: settings
        );
      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: ((context) =>  SignUp()),
            settings: settings
        );
      case RoutesName.forgetPassword:
        return MaterialPageRoute(
            builder: ((context) =>  ForgetPasswordView()),
            settings: settings
        );
      case RoutesName.layout_view:
        return MaterialPageRoute(
            builder: ((context) =>  LayoutView()),
            settings: settings
        );
        default:
          return MaterialPageRoute(
              builder: ((context) =>  SplashView()),
              settings: settings
          );
    }
  }
}