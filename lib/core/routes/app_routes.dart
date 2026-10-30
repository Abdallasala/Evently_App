import 'package:evently_app_c13_sun_7_pm/core/routes/pages_routes_name.dart';
import 'package:evently_app_c13_sun_7_pm/module/CreateEvent/create_event.dart';
import 'package:evently_app_c13_sun_7_pm/module/Edit%20Events/edit_view.dart';
import 'package:evently_app_c13_sun_7_pm/module/Event%20Details/event_details.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/layout_view.dart';
import 'package:evently_app_c13_sun_7_pm/module/onBording/onBoarding%20Explain%20App/on_boarding_explain%20_app.dart';
import 'package:flutter/material.dart';

import '../../module/forgetPassword/forget_password_view.dart';
import '../../module/onBording/on_bording_view.dart';
import '../../module/sign in/sign_in.dart';
import '../../module/signup/sign_up.dart';
import '../../module/splash/splash_view.dart';

abstract class AppRoutes {
  static Route onGenrateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.initial:
        return MaterialPageRoute(
          builder: ((context) => const SplashView()),
          settings: settings,
        );
      case RoutesName.onBoradingView:
        return MaterialPageRoute(
          builder: ((context) => const OnBordingView()),
          settings: settings,
        );
      case RoutesName.onBoardingViewExplainApp:
        return MaterialPageRoute(
          builder: ((context) => const OnBoardingExplainApp()),
          settings: settings,
        );
      case RoutesName.signIn:
        return MaterialPageRoute(
          builder: ((context) => const SignIn()),
          settings: settings,
        );
      case RoutesName.signUp:
        return MaterialPageRoute(
          builder: ((context) => const SignUp()),
          settings: settings,
        );
      case RoutesName.forgetPassword:
        return MaterialPageRoute(
          builder: ((context) => const ForgetPasswordView()),
          settings: settings,
        );
      case RoutesName.layout_view:
        return MaterialPageRoute(
          builder: ((context) => const LayoutView()),
          settings: settings,
        );
      case RoutesName.create_event:
        return MaterialPageRoute(
          builder: ((context) => const CreateEvent()),
          settings: settings,
        );
      case RoutesName.event_details:
        return MaterialPageRoute(
          builder: ((context) => const EventDetails()),
          settings: settings,
        );
      case RoutesName.edit_event:
        return MaterialPageRoute(
          builder: ((context) => const EditView()),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: ((context) => const SplashView()),
          settings: settings,
        );
    }
  }
}
