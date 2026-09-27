import 'package:evently_app_c13_sun_7_pm/core/constant/app_constant.dart';
import 'package:evently_app_c13_sun_7_pm/core/custom_text_field.dart';
import 'package:evently_app_c13_sun_7_pm/core/extensions/center_ext.dart';
import 'package:evently_app_c13_sun_7_pm/core/extensions/padding_ext.dart';
import 'package:evently_app_c13_sun_7_pm/core/extensions/validations.dart';
import 'package:evently_app_c13_sun_7_pm/core/routes/pages_routes_name.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_sun_7_pm/main.dart';
import 'package:evently_app_c13_sun_7_pm/utiles/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final form_state =GlobalKey<FormState>();
  final _emailcontroller =TextEditingController();
  final _passwordcontroller =TextEditingController();
  final _namecontroller =TextEditingController();
  final _re_password_controller =TextEditingController();
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
        backgroundColor: ColorPalette.white,
        title: Text('Register',style:theme.titleLarge?.copyWith(


        ) ,),
      ),
      body:Form(
        key: form_state,
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AppConstant.evently_icon,height: size.height*.25,),
            CustomTextField(
              controller: _namecontroller,
              onValidate: (value){
                if(value ==null ||value.trim().isEmpty){
                  return 'plz enter your name';
                }
                return null ;
              },
              hint: 'Name',
              hintColor: ColorPalette.generalGreyColor,

              prefixIcon: ImageIcon(AssetImage(AppConstant.person_icon,)
                ,
                color:ColorPalette.generalGreyColor,
              ),
            ).setOnlyPadding(context,.02,.01,.0,.0),
            CustomTextField(
              controller: _emailcontroller,
              onValidate: (value){
                if(value ==null ||value.trim().isEmpty){
                  return 'plz enter your email';
                }
                if(!Validations.validateEmail(value)){
                  return 'plz enter a validate email';
                }
                return null ;
              },
              hint: 'Email',
              hintColor: ColorPalette.generalGreyColor,

              prefixIcon: ImageIcon(AssetImage(AppConstant.mail_icon,)
                ,
                color:ColorPalette.generalGreyColor,
              ),
            ).setOnlyPadding(context,.02,.01,.0,.0),
            CustomTextField(
              controller: _passwordcontroller,
              onValidate: (value){
                if(value ==null ||value.trim().isEmpty){
                  return 'plz enter your password';
                }
                if(!Validations.validatePassword(value)){
                  return 'plz enter a validate password';
                }
                return null;
              },
              hint: 'password',
              hintColor: ColorPalette.generalGreyColor,
              isPassword: true,
              maxLines: 1,
              prefixIcon: ImageIcon(AssetImage(AppConstant.lock_icon,)
                ,
                color:ColorPalette.generalGreyColor,
              ),).setOnlyPadding(context,.02,.01,.0,.0),
            CustomTextField(
              controller: _re_password_controller,
              onValidate:
                  (value){
                    if(value ==null ||value.trim().isEmpty){
                      return 'plz enter your re_password';
                    }
                if(value != _passwordcontroller.text){
                  return 'the password not match';
                }

              },
              hint: 'Re-password',
              hintColor: ColorPalette.generalGreyColor,
              isPassword: true,
              maxLines: 1,
              prefixIcon: ImageIcon(AssetImage(AppConstant.lock_icon,)
                ,
                color:ColorPalette.generalGreyColor,
              ),).setOnlyPadding(context,.02,.01,.0,.0),
            ElevatedButton(onPressed: ()async{
           if(form_state.currentState!.validate()){
             FirebaseAuth_Email_Password.create_Account(
                 _emailcontroller.text,
                 _passwordcontroller.text
             ).then(
                 (onValue){
                   EasyLoading.dismiss();
                   if(onValue ==true){
                     navigatorKey.currentState!.pushNamedAndRemoveUntil(
                         RoutesName.signIn,
                         ((route) => false));
                   }
                 }
             );
           }
            },

                style:ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorPalette.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                ) ,
                child: Text('Register',
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
      ),
    );
  }
}
