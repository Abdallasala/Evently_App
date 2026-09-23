import 'package:evently_app_c13_sun_7_pm/core/constant/app_constant.dart';
import 'package:evently_app_c13_sun_7_pm/core/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../../core/extensions/padding_ext.dart' show PaddingtoWidget;
import '../../core/theme/color_palette.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

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
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title: Text('Forget password',style:theme.titleLarge?.copyWith(


        ) ,),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(AppConstant.pasword_forget,height: 220,),
        SizedBox(height: 10,),
          CustomTextField(
            hint: 'Email',
            hintColor: ColorPalette.generalGreyColor,

            prefixIcon: ImageIcon(AssetImage(AppConstant.mail_icon,)
              ,
              color:ColorPalette.generalGreyColor,
            ),
          ).setOnlyPadding(context,.02,.01,.0,.0),
          ElevatedButton(onPressed: (){},

              style:ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: ColorPalette.primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
              ) ,
              child: Text('Reset Password',
                style: theme.titleMedium?.copyWith(
                    color: ColorPalette.white,
                    fontWeight: FontWeight.w600
                ),
              )).setVerticalPadding(context, .03),
        ],
      ),
    );
  }
}
