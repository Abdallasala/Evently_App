import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:evently_app_c13_sun_7_pm/core/extensions/padding_ext.dart';
import 'package:evently_app_c13_sun_7_pm/core/routes/pages_routes_name.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_sun_7_pm/main.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/setting_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

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
    final userEmail = user?.email ?? 'No Email';
    final userPhoto = user?.photoURL;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: mediaQuery.size.height * 0.25,
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
            decoration: const BoxDecoration(
              color: ColorPalette.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(64.0),
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.all(4.0),
                  decoration: const BoxDecoration(
                    color: ColorPalette.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(1000),
                      bottomRight: Radius.circular(1000),
                      topRight: Radius.circular(1000),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(1000),
                      bottomRight: Radius.circular(1000),
                      topRight: Radius.circular(1000),
                      topLeft: Radius.circular(25),
                    ),
                    child: (userPhoto != null && userPhoto.isNotEmpty)
                        ? Image.network(
                            userPhoto,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset("assets/icons/route_logo.png"),
                          )
                        : Image.asset("assets/icons/route_logo.png"),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: ColorPalette.white,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        userEmail,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: ColorPalette.white,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: mediaQuery.size.height * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Language",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: mediaQuery.size.height * 0.01),
              CustomDropdown<String>(
                key: ValueKey(provider.currentlangage),
                initialItem: provider.isEnglish() ? "English" : "عربي",
                items: provider.listLanguage,
                onChanged: (value) {
                  if (value == "English") {
                    provider.setCurrentLangage("en");
                  }
                  if (value == "عربي") {
                    provider.setCurrentLangage("ar");
                  }
                },
                decoration: CustomDropdownDecoration(
                  closedBorder: Border.all(
                    color: ColorPalette.primaryColor,
                    width: 1.8,
                  ),
                  closedBorderRadius: BorderRadius.circular(18.0),
                  closedSuffixIcon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 28,
                    color: ColorPalette.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: mediaQuery.size.height * 0.03),
              Text(
                "Theme Mode",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: mediaQuery.size.height * 0.01),
              CustomDropdown<String>(
                key: ValueKey(provider.current_theme),
                initialItem: provider.isDark() ? "Dark" : "Light",
                items: provider.listTheme,
                onChanged: (value) {
                  if (value == "Dark") {
                    provider.setCurrentTheme(ThemeMode.dark);
                  }
                  if (value == "Light") {
                    provider.setCurrentTheme(ThemeMode.light);
                  }
                },
                decoration: CustomDropdownDecoration(
                  closedBorder: Border.all(
                    color: ColorPalette.primaryColor,
                    width: 1.8,
                  ),
                  closedBorderRadius: BorderRadius.circular(18.0),
                  closedSuffixIcon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 28,
                    color: ColorPalette.primaryColor,
                  ),
                ),
              ),
            ],
          ).setHorizontalPadding(context, 0.035),
          const Spacer(),
          ElevatedButton(
            onPressed: () async {
              EasyLoading.show();
              await FirebaseAuth.instance.signOut();
              EasyLoading.dismiss();
              if (context.mounted) {
                navigatorKey.currentState!.pushNamedAndRemoveUntil(
                  RoutesName.signIn,
                  (route) => false,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  'Log Out',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ).setHorizontalPadding(context, 0.035),
          SizedBox(height: mediaQuery.size.height * 0.04),
        ],
      ),
    );
  }
}
