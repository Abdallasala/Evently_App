import 'package:evently_app_c13_sun_7_pm/core/constant/app_constant.dart';
import 'package:evently_app_c13_sun_7_pm/core/custom_text_field.dart';
import 'package:evently_app_c13_sun_7_pm/core/extensions/center_ext.dart';
import 'package:evently_app_c13_sun_7_pm/core/extensions/extensions.dart';
import 'package:evently_app_c13_sun_7_pm/core/routes/app_routes.dart';
import 'package:evently_app_c13_sun_7_pm/core/routes/pages_routes_name.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_sun_7_pm/main.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context).textTheme;
    var size =MediaQuery.of(context).size;
    var style_underline = theme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.underline,
        decorationThickness: 1.5,
        color: ColorPalette.primaryColor,
        decorationColor: ColorPalette.primaryColor
    );
    return Scaffold(
      body:Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(AppConstant.evently_icon,height: size.height*.25,),
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
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(onPressed: (){
              navigatorKey.currentState!.pushNamed(RoutesName.forgetPassword);
            }, child:Text('Forget Password',
            style: style_underline
            )),
          ).setVerticalPadding(context, .01),
          ElevatedButton(onPressed: (){},

              style:ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: ColorPalette.primaryColor,
                padding: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
              ) ,
              child: Text('Login',
          style: theme.titleLarge?.copyWith(
            color: ColorPalette.white,
            fontWeight: FontWeight.w600
          ),
          )),
          Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
            children: [
              TextSpan(
                text: "Don’t Have Account ? ",
                style: theme.titleMedium
              ),
              WidgetSpan(
                child: GestureDetector(
                  onTap: (){
                    navigatorKey.currentState!.pushNamed(RoutesName.signUp);
                  },
                  child: Text("create account ",
                      style:style_underline
                  ),
                ),
              ),
            ]
          ),).setVerticalPadding(context, .02),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                indent: 20,
                  endIndent: 20,
                  color: ColorPalette.generalGreyColor,
                ),
              ),
              Text('OR'
              ,style: theme.titleMedium?.copyWith(
                  color: ColorPalette.primaryColor
                ),
              ),

              Expanded(
                child: Divider(
                  indent: 20,
                  endIndent: 20,
                  color: ColorPalette.generalGreyColor,
                ),
              ),
            ],
          ).setVerticalPadding(context, .01),
          ElevatedButton(onPressed: (){},

              style:ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: ColorPalette.white,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: ColorPalette.primaryColor)
                  ),
              ) ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: (){},
                      child: Image.asset(AppConstant.google_icon,
                      height: 25.0,
                      )),
                  SizedBox(width: 10.0,),
                  Text('Login With Google',
                    style: theme.titleMedium?.copyWith(
                        color: ColorPalette.generalGreyColor,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              )),
        ],
      ) .setCenter().setVerticalPadding(context, .02),//this i'am using extension i did extension on widget
    );
  }
}
