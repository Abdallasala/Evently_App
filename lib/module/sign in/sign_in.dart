import 'package:evently_app_c13_sun_7_pm/core/constant/app_constant.dart';
import 'package:evently_app_c13_sun_7_pm/core/custom_text_field.dart';
import 'package:evently_app_c13_sun_7_pm/core/extensions/extensions.dart';
import 'package:evently_app_c13_sun_7_pm/core/routes/pages_routes_name.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_sun_7_pm/main.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../core/extensions/validations.dart';
import '../../utiles/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final form_state = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    var style_underline = theme.titleMedium?.copyWith(
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
      decorationThickness: 1.5,
      color: ColorPalette.primaryColor,
      decorationColor: ColorPalette.primaryColor,
    );
    var provider = Provider.of<SettingProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: form_state,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  AppConstant.evently_icon,
                  height: size.height * .22,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _emailcontroller,
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!Validations.validateEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  hint: 'Email',
                  hintColor: ColorPalette.generalGreyColor,
                  prefixIcon: const ImageIcon(
                    AssetImage(AppConstant.mail_icon),
                    color: ColorPalette.generalGreyColor,
                  ),
                ).setOnlyPadding(context, .02, .01, .0, .0),
                CustomTextField(
                  controller: _passwordcontroller,
                  onValidate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  hint: 'Password',
                  hintColor: ColorPalette.generalGreyColor,
                  isPassword: true,
                  maxLines: 1,
                  prefixIcon: const ImageIcon(
                    AssetImage(AppConstant.lock_icon),
                    color: ColorPalette.generalGreyColor,
                  ),
                ).setOnlyPadding(context, .02, .01, .0, .0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      navigatorKey.currentState!.pushNamed(RoutesName.forgetPassword);
                    },
                    child: Text(
                      'Forget Password',
                      style: style_underline,
                    ),
                  ),
                ).setVerticalPadding(context, .01),
                ElevatedButton(
                  onPressed: () async {
                    if (form_state.currentState!.validate()) {
                      Firebase_funcation.signin_with_email_and_password(
                        _emailcontroller.text.trim(),
                        _passwordcontroller.text.trim(),
                      ).then((onValue) {
                        EasyLoading.dismiss();
                        if (onValue == true) {
                          navigatorKey.currentState!.pushNamedAndRemoveUntil(
                            RoutesName.layout_view,
                            ((route) => false),
                          );
                        }
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorPalette.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: theme.titleLarge?.copyWith(
                      color: ColorPalette.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Don’t Have Account ? ",
                        style: theme.titleMedium,
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            navigatorKey.currentState!.pushNamed(RoutesName.signUp);
                          },
                          child: Text(
                            "Create Account",
                            style: style_underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).setVerticalPadding(context, .02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Divider(
                        indent: 20,
                        endIndent: 20,
                        color: ColorPalette.generalGreyColor,
                      ),
                    ),
                    Text(
                      'OR',
                      style: theme.titleMedium?.copyWith(
                        color: ColorPalette.primaryColor,
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        indent: 20,
                        endIndent: 20,
                        color: ColorPalette.generalGreyColor,
                      ),
                    ),
                  ],
                ).setVerticalPadding(context, .01),
                ElevatedButton(
                  onPressed: () async {
                    final userCredential = await Firebase_funcation.signInWithGoogle();
                    print("Google result: $userCredential");
                    if (userCredential != null) {
                      navigatorKey.currentState!.pushNamedAndRemoveUntil(
                        RoutesName.layout_view,
                        (routes) => false,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorPalette.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: ColorPalette.primaryColor),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppConstant.google_icon,
                        height: 25.0,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        'Login With Google',
                        style: theme.titleMedium?.copyWith(
                          color: ColorPalette.generalGreyColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: ColorPalette.primaryColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            provider.setCurrentLangage('en');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: provider.isEnglish()
                                  ? ColorPalette.primaryColor
                                  : Colors.transparent,
                            ),
                            child: ImageIcon(
                              const AssetImage('assets/icons/America1.png'),
                              color: provider.isEnglish()
                                  ? ColorPalette.white
                                  : ColorPalette.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            provider.setCurrentLangage('ar');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: !provider.isEnglish()
                                  ? ColorPalette.primaryColor
                                  : Colors.transparent,
                            ),
                            child: ImageIcon(
                              const AssetImage('assets/icons/EG.png'),
                              color: !provider.isEnglish()
                                  ? ColorPalette.white
                                  : ColorPalette.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ).setHorizontalPadding(context, .04),
          ),
        ),
      ),
    );
  }
}
