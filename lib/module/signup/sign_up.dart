import 'package:evently_app_c13_sun_7_pm/core/constant/app_constant.dart';
import 'package:evently_app_c13_sun_7_pm/core/custom_text_field.dart';
import 'package:evently_app_c13_sun_7_pm/core/extensions/center_ext.dart';
import 'package:evently_app_c13_sun_7_pm/core/extensions/padding_ext.dart';
import 'package:evently_app_c13_sun_7_pm/core/routes/pages_routes_name.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_sun_7_pm/main.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    var theme =Theme.of(context).textTheme ;
    var style_underline = theme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.underline,
        decorationThickness: 1.5,
        color: ColorPalette.primaryColor,
        decorationColor: ColorPalette.primaryColor
    );
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Register',style:theme.titleLarge?.copyWith(


        ) ,),
      ),
      body:Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(AppConstant.evently_icon,height: size.height*.25,),
          CustomTextField(
            hint: 'Name',
            hintColor: ColorPalette.generalGreyColor,

            prefixIcon: ImageIcon(AssetImage(AppConstant.person_icon,)
              ,
              color:ColorPalette.generalGreyColor,
            ),
          ).setOnlyPadding(context,.02,.01,.0,.0),
          CustomTextField(
            hint: 'Email',
            hintColor: ColorPalette.generalGreyColor,

            prefixIcon: ImageIcon(AssetImage(AppConstant.mail_icon,)
              ,
              color:ColorPalette.generalGreyColor,
            ),
          ).setOnlyPadding(context,.02,.01,.0,.0),
          CustomTextField( hint: 'password',
            hintColor: ColorPalette.generalGreyColor,
            isPassword: true,
            maxLines: 1,
            prefixIcon: ImageIcon(AssetImage(AppConstant.lock_icon,)
              ,
              color:ColorPalette.generalGreyColor,
            ),).setOnlyPadding(context,.02,.01,.0,.0),
          CustomTextField( hint: 'Re-password',
            hintColor: ColorPalette.generalGreyColor,
            isPassword: true,
            maxLines: 1,
            prefixIcon: ImageIcon(AssetImage(AppConstant.lock_icon,)
              ,
              color:ColorPalette.generalGreyColor,
            ),).setOnlyPadding(context,.02,.01,.0,.0),
          ElevatedButton(onPressed: (){},

              style:ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: ColorPalette.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
              ) ,
              child: Text('Create Account',
                style: theme.titleLarge?.copyWith(
                    color: ColorPalette.white,
                    fontWeight: FontWeight.w600
                ),
              )).setVerticalPadding(context, .01),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
                children: [
                  TextSpan(
                      text: "Already Have Account ? ",
                      style: theme.titleMedium
                  ),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: (){
                        navigatorKey.currentState!.pushNamed(RoutesName.signIn);
                      },
                      child: Text("login ",
                          style:style_underline
                      ),
                    ),
                  ),
                ]
            ),).setVerticalPadding(context, .02),


        ],
      ) .setCenter().setVerticalPadding(context, .02),
    );
  }
}
