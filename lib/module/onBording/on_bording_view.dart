import 'package:evently_app_c13_sun_7_pm/core/routes/pages_routes_name.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_sun_7_pm/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/extensions/padding_ext.dart';
import '../layout/setting_provider.dart';

class OnBordingView extends StatelessWidget {
  const OnBordingView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<SettingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const ImageIcon(
          AssetImage("assets/images/evently icon image.png"),
          size: 120,
          color: ColorPalette.primaryColor,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Image(
              image: const AssetImage('assets/images/on-boarding-page-intro.png'),
              height: size.height * 0.45,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 15),
            Text(
              'Personalize Your Experience',
              style: theme.titleMedium!.copyWith(
                color: ColorPalette.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.',
              style: theme.titleSmall!.copyWith(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Language',
                  style: theme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: ColorPalette.primaryColor),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          provider.setCurrentLangage('en');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: provider.isEnglish()
                                ? ColorPalette.primaryColor
                                : Colors.transparent,
                          ),
                          child: ImageIcon(
                            const AssetImage('assets/icons/America1.png'),
                            color: provider.isEnglish()
                                ? ColorPalette.white
                                : ColorPalette.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          provider.setCurrentLangage('ar');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorPalette.primaryColor
                            ),
                            borderRadius: BorderRadius.circular(16),
                            color: !provider.isEnglish()
                                ? ColorPalette.primaryColor
                                : Colors.transparent,
                          ),
                          child: ImageIcon(
                            const AssetImage('assets/icons/EG.png'),
                            color: !provider.isEnglish()
                                ? ColorPalette.white
                                : ColorPalette.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text(
                  'Theme',
                  style: theme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: ColorPalette.primaryColor,width: 1),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          provider.setCurrentTheme(ThemeMode.light);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: !provider.isDark()
                                ? ColorPalette.primaryColor
                                : Colors.transparent,
                          ),
                          child: Icon(
                            Icons.wb_sunny_outlined,
                            color: !provider.isDark()
                                ? ColorPalette.white
                                : ColorPalette.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          provider.setCurrentTheme(ThemeMode.dark);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: provider.isDark()
                                ? ColorPalette.primaryColor
                                : Colors.transparent,
                          ),
                          child: Icon(
                            Icons.nightlight_round,
                            color: provider.isDark()
                                ? ColorPalette.white
                                : ColorPalette.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  navigatorKey.currentState!.pushNamedAndRemoveUntil(
                    RoutesName.signIn,
                    (routes) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: ColorPalette.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Let’s Start',
                  style: theme.titleLarge?.copyWith(
                    color: ColorPalette.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ).setVerticalPadding(context, .01),
            ),
            const SizedBox(height: 20),
          ],
        ).setHorizontalPadding(context, .05),
      ),
    );
  }
}
