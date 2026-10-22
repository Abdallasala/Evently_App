import 'package:evently_app_c13_sun_7_pm/core/constant/app_constant.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_sun_7_pm/l10n/generated/app_localizations.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/favorite/favorites_view.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/home/home_view.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/map/map_view.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/profile/profile_view.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/pages_routes_name.dart';
import '../../models/bottom_navigation_bar _item_model.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  final List<Widget> currentTab = const [
    HomeView(),
    MapView(),
  FavoritesView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingProvider>(context);
    var local = AppLocalizations.of(context)!;

    List<BottomNavigationBarIItemModel> bottomNavigationBarList = [
      BottomNavigationBarIItemModel(
        label: local.home,
        selected_icn: AppConstant.selected_home,
        un_selected_icn: AppConstant.un_selected_home,
      ),
      BottomNavigationBarIItemModel(
        label: local.map,
        selected_icn: AppConstant.selected_map_icn,
        un_selected_icn: AppConstant.un_selected_map_icn,
      ),
      BottomNavigationBarIItemModel(
        label: local.favorite,
        selected_icn: AppConstant.selected_favorite_icn,
        un_selected_icn: AppConstant.un_selected_favorite_icn,
      ),
      BottomNavigationBarIItemModel(
        label: local.profile,
        selected_icn: AppConstant.selected_user_icn,
        un_selected_icn: AppConstant.un_selected_user_icn,
      ),
    ];

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RoutesName.create_event);
        },
        child: const CircleAvatar(
          radius: 29,
          backgroundColor: ColorPalette.white,
          child: CircleAvatar(
            radius: 26,
            backgroundColor: ColorPalette.primaryColor,
            child: Icon(
              Icons.add,
              color: ColorPalette.white,
              size: 28,
            ),
          ),
        ),
      ),
      body: currentTab[provider.currentNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.currentNavIndex,
        onTap: (index) {
          provider.changeNavIndex(index);
        },

        items: bottomNavigationBarList.map((item) {
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
