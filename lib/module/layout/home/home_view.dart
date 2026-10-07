import 'package:evently_app_c13_sun_7_pm/core/extensions/padding_ext.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/home/widget/event_card_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    var theme =Theme.of(context).textTheme;
    return SingleChildScrollView(
      physics:const ClampingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: size.height*.25,
              padding: EdgeInsets.only(top: 20,bottom: 20),
              decoration:BoxDecoration(
                color: ColorPalette.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ) ,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Welcome Back ✨',
                          style: theme.titleSmall!.copyWith(
                            color: ColorPalette.white,
                          ),
                          ),
                          Text('John Safwat',
                            style: theme.titleMedium!.copyWith(
                              color: ColorPalette.white,
                            fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(children: [
                            Icon(Icons.location_on_outlined,color: ColorPalette.white,),
                            Text('Cairo , Egypt',
                              style: theme.titleSmall!.copyWith(
                                color: ColorPalette.white,
                              ),
                            ),
                          ],)
                        ],

                      ).setHorizontalPadding(context,.04),
                      Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.wb_sunny_outlined,color: ColorPalette.white,),
                          SizedBox(width: 5,),
                          Container(
                            height: size.height*35/831.39,
                            width: 35,
                            alignment: Alignment.center,
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              color: ColorPalette.white
                            ) ,
                            child: Text('EN',
                              style: theme.titleSmall!.copyWith(
                                color: ColorPalette.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ).setHorizontalPadding(context, .01),
                    ],
                  ),
                ],
              ),

            ),
         //   SizedBox(height: 20,),
            ListView.separated(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder:(context,index)=>EventCard() ,
                separatorBuilder: (context,index)=>SizedBox(height: 10,),
                itemCount: 5
            ).setVerticalPadding(context, .03),
          ],
        )
    );
  }
}
