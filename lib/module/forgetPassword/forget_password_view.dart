import 'package:evently_app_c13_sun_7_pm/core/constant/app_constant.dart';
import 'package:evently_app_c13_sun_7_pm/core/custom_text_field.dart';
import 'package:evently_app_c13_sun_7_pm/utiles/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../core/extensions/padding_ext.dart' show PaddingtoWidget;
import '../../core/services/snack_bar_service.dart';
import '../../core/theme/color_palette.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
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
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AppConstant.pasword_forget,height: 220,),
          SizedBox(height: 10,),
            CustomTextField(
              controller: _emailController,
              hint: 'Email',
              hintColor: ColorPalette.generalGreyColor,

              prefixIcon: ImageIcon(AssetImage(AppConstant.mail_icon,)
                ,
                color:ColorPalette.generalGreyColor,
              ),
            ).setOnlyPadding(context,.02,.01,.0,.0),
            ElevatedButton(onPressed: ()async{
              try {
                EasyLoading.show();
                await Firebase_funcation.resetPassword(_emailController.text);
                EasyLoading.dismiss();
                SnackBarService.showSuccessMessage("Reset Password Success");
                if (context.mounted) {
                  Navigator.pop(context);
                }
              } catch (e) {
                EasyLoading.dismiss();
                SnackBarService.showErrorMessage("Failed to reset Password : $e");
              }
            },

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
      ),
    );
  }
}
