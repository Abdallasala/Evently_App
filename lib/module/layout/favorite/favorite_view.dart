import 'package:evently_app_c13_sun_7_pm/core/custom_text_field.dart';
import 'package:evently_app_c13_sun_7_pm/core/extensions/padding_ext.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/home/widget/event_card_widget.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          CustomTextField(

            hint: 'Search for Event',
             hintColor: ColorPalette.primaryColor,
             prefixIcon: Icon(Icons.search,color: ColorPalette.primaryColor,),
          ).setHorizontalAndVerticalPadding(context, .02,.02),
        //  SizedBox(height: 10,),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder:(context,index)=>EventCard() ,
              separatorBuilder: (context,index)=>SizedBox(height: 10,),
              itemCount: 5
          ).setVerticalPadding(context, .03),
        ],
      ),
    );
  }
}
