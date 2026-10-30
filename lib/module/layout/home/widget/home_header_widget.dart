import 'package:evently_app_c13_sun_7_pm/core/services/location_services.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/setting_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/color_palette.dart';

class HomeHeaderWidget extends StatefulWidget {
  const HomeHeaderWidget({super.key});

  @override
  State<HomeHeaderWidget> createState() => _HomeHeaderWidgetState();
}

class _HomeHeaderWidgetState extends State<HomeHeaderWidget> {
  String locationText = "Cairo, Egypt";
  bool isLoadingLocation = false;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    if (isLoadingLocation) return;
    setState(() {
      isLoadingLocation = true;
    });
    String address = await LocationServices.getCurrentCityAndCountry();
    if (mounted) {
      setState(() {
        locationText = address;
        isLoadingLocation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    var provider = Provider.of<SettingProvider>(context);

    final user = FirebaseAuth.instance.currentUser;
    final userName = (user?.displayName != null && user!.displayName!.isNotEmpty)
        ? user.displayName!
        : (user?.email != null && user!.email!.contains('@')
            ? user.email!.split('@')[0]
            : 'User');

    return Container(
      height: mediaQuery.size.height * 0.25,
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
      decoration: const BoxDecoration(
        color: ColorPalette.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back ✨",
                    style: theme.textTheme.titleSmall
                        ?.copyWith(color: ColorPalette.white),
                  ),
                  Text(
                    userName,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      _fetchLocation();
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/un_selected_map_icn.png",
                          height: 25,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isLoadingLocation ? "Locating..." : locationText,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorPalette.white,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      provider.toggleTheme();
                    },
                    child: Icon(
                      provider.isDark()
                          ? Icons.wb_sunny_outlined
                          : Icons.wb_sunny_rounded,
                      size: 28,
                      color: ColorPalette.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      provider.toggleLanguage();
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorPalette.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        provider.isEnglish() ? "EN" : 'AR',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: ColorPalette.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
