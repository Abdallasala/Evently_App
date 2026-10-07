import 'package:evently_app_c13_sun_7_pm/core/constant/app_constant.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/favorite/favorite_view.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/home/home_view.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/map/map_view.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/profile/profile.dart';
import 'package:flutter/material.dart';

import '../../core/routes/pages_routes_name.dart';
import '../../models/bottom_navigation_bar _item_model.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int current_index =0;
  List<BottomNavigationBarIItemModel> bottom_navigation_bar_list =[
    BottomNavigationBarIItemModel( label: 'home', selected_icn: AppConstant.selected_home, un_selected_icn: AppConstant.un_selected_home),
    BottomNavigationBarIItemModel(label: 'map', selected_icn: AppConstant.selected_map_icn, un_selected_icn: AppConstant.un_selected_map_icn),
    BottomNavigationBarIItemModel(label: 'favorite', selected_icn: AppConstant.selected_favorite_icn, un_selected_icn: AppConstant.un_selected_favorite_icn),
    BottomNavigationBarIItemModel(label: 'profile', selected_icn: AppConstant.selected_user_icn, un_selected_icn: AppConstant.un_selected_user_icn),
  ];
  List<Widget> current_tap =[HomeView(), MapView(),FavoriteView(),ProfileView(),];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, RoutesName.create_event);
        },
        child: CircleAvatar(
          radius: 29,
          backgroundColor: ColorPalette.white,
          child: CircleAvatar(
            radius: 26,
             backgroundColor: ColorPalette.primaryColor,
            child: Icon(Icons.add,color: ColorPalette.white,size: 28,),
          ),
            ),
      ),
      body: current_tap[current_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current_index,
        onTap: (index) {
          setState(() {
            current_index = index;
          });
        },
        selectedItemColor: ColorPalette.white,
        unselectedItemColor: ColorPalette.white,
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorPalette.primaryColor,
        items: bottom_navigation_bar_list.map((item) {
          return BottomNavigationBarItem(
            activeIcon: ImageIcon(
              AssetImage(item.selected_icn),
            ),
            icon: ImageIcon(
              AssetImage(item.un_selected_icn),
            ),
            label: item.label,
          );
        }).toList(),
      ),
    );
  }
}
