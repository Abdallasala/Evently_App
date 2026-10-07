import 'package:evently_app_c13_sun_7_pm/core/extensions/extensions.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:flutter/material.dart';

import '../../../../core/routes/pages_routes_name.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    var theme =Theme.of(context).textTheme;
    return Container(

      height: 200,
      decoration: BoxDecoration(
      border: Border.all(
        color: ColorPalette.primaryColor,
        width: 1.5
      ),
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(image: AssetImage('assets/images/category/birthday.png',),
            fit:BoxFit.cover )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Container(
         //    height:49,
             width: 50,
            alignment: Alignment.center,
             decoration:BoxDecoration(
                 borderRadius: BorderRadius.all(
                   Radius.circular(8),
                 ),
                 color: ColorPalette.white
             ) ,
             child: Column(
               children: [
                 Text('21 Nov',
                   style: theme.titleLarge!.copyWith(
                     color: ColorPalette.primaryColor,
                   ),
                   textAlign: TextAlign.center,

                 ),
               ],
             ),
           ),
           Container(
           //  height:49,
            // width: 43,
             //  alignment: Alignment.center,
             padding: EdgeInsets.all(5),
             decoration:BoxDecoration(
                 borderRadius: BorderRadius.all(
                   Radius.circular(8),
                 ),
                 color: ColorPalette.white
             ) ,
             child: Row(
               children: [
                 Text('This is a Birthday Party ',
                   style: theme.titleSmall!.copyWith(
                   //  color: ColorPalette.primaryColor,
                     fontWeight: FontWeight.bold,
                     fontSize: 14
                   ),

                 ),
                 Spacer(),
                 Icon(Icons.favorite_border_outlined,color: ColorPalette.primaryColor,)
               ],
             ),
           ),
         ],
      ).setHorizontalPadding(context,.01).setVerticalPadding(context, .01),
    );
  }
}
