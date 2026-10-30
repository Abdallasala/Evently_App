import 'package:evently_app_c13_sun_7_pm/core/routes/pages_routes_name.dart';
import 'package:evently_app_c13_sun_7_pm/core/services/shared_pref_helper.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_sun_7_pm/models/on_boarding_data_model.dart';
import 'package:flutter/material.dart';

class OnBoardingExplainApp extends StatefulWidget {
  const OnBoardingExplainApp({super.key});

  @override
  State<OnBoardingExplainApp> createState() => _OnBoardingExplainAppState();
}

class _OnBoardingExplainAppState extends State<OnBoardingExplainApp> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnBoardingDataModel> _onboardingList = [
    OnBoardingDataModel(
      image: "assets/images/on-boarding-page-1.png",
      title: "Find Events That Inspire You",
      description:
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone.",
    ),
    OnBoardingDataModel(
      image: "assets/images/on-boarding-page-2.png",
      title: "Effortless Event Planning",
      description:
          "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we've got you covered.",
    ),
    OnBoardingDataModel(
      image: "assets/images/on-boarding-page-3.png",
      title: "Connect with Friends & Share Moments",
      description:
          "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together.",
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    await SharedPrefHelper.setFirstTime(false);
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.signIn,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onboardingList.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final item = _onboardingList[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          item.image,
                          height: size.height * 0.38,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 25),
                        Text(
                          item.title,
                          style: theme.titleLarge?.copyWith(
                            color: ColorPalette.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          item.description,
                          style: theme.titleSmall?.copyWith(
                            fontSize: 14,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left Arrow (Back) - Only visible when index > 0
                  if (_currentIndex > 0)
                    GestureDetector(
                      onTap: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ColorPalette.primaryColor,
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: ColorPalette.primaryColor,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 48),

                  // Center Dots Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingList.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentIndex == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? ColorPalette.primaryColor
                              : ColorPalette.generalGreyColor.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),

                  // Right Arrow (Next or Finish)
                  GestureDetector(
                    onTap: () {
                      if (_currentIndex < _onboardingList.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _finishOnboarding();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.primaryColor,
                      ),
                      child: Icon(
                        _currentIndex == _onboardingList.length - 1
                            ? Icons.check
                            : Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
