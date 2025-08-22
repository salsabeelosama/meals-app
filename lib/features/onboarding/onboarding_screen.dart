import 'package:carousel_slider/carousel_slider.dart';
import 'package:depi_project/core/app_color.dart';
import 'package:depi_project/core/app_const.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<String> titels = [
    "save_your_meals_ingredient",
    "use_our_app_the_best_choice",
    "our_app_your_ultimate_choice",
  ];
  List<String> subtitels = [
    "add_your_meals_and_its_ingredients_and_we_will_save_it_for_you",
    "the_best_choice_for_your_kitchen_do_not_hesitate",
    "all_the_best_restaurants_and_their_top_menus_are_ready_for_you",
  ];

  void changeLanguage() {
    if (context.locale == Locale('en')) {
      context.setLocale(Locale("ar"));
    } else {
      context.setLocale(Locale("en"));
    }
  }

  int pageIndex = 0;

  CarouselSliderController sliderController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 32.w,
            top: 372.h,
            child: Container(
              width: 311.w,
              height: 400.h,
              decoration: BoxDecoration(
                color: AppColor.primaryColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(48),
              ),
              child: Column(
                children: [
                  CarouselSlider(
                    carouselController: sliderController,
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        debugPrint('$index');
                        setState(() {
                          pageIndex = index;
                        });
                      },
                      height: 330,
                      disableCenter: true,
                      viewportFraction: 1,
                    ),
                    items: List.generate(titels.length, (index) {
                      return Column(
                        children: [
                          SizedBox(height: 30.h),
                          Text(
                            textAlign: TextAlign.center,
                            titels[index].tr(),
                            style: TextStyle(
                              fontSize: 32.sp,
                              color: AppColor.backgroundColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            textAlign: TextAlign.center,
                            subtitels[index].tr(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColor.backgroundColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 30.h),
                          DotsIndicator(
                            dotsCount: titels.length,
                            position: pageIndex.toDouble(),
                            onTap: (index) {
                              debugPrint('$index');
                              sliderController.animateToPage(index);
                            },
                            decorator: DotsDecorator(
                              size: Size(26.w, 8.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              activeSize: Size(26.w, 8.h),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: AppColor.subColor, // Inactive color
                              activeColor: AppColor.backgroundColor,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  pageIndex != 2
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          SizedBox(width: 10.w),
                          TextButton(
                            onPressed: () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool('isFirstTime', true);
                              Navigator.pushReplacementNamed(
                                context,
                                homeLayout,
                              );
                            },
                            child: Text(
                              "skip".tr(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColor.backgroundColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 130.w),
                          TextButton(
                            onPressed: () {
                              sliderController.nextPage();
                            },
                            child: Text(
                              "next".tr(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColor.backgroundColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                        ],
                      )
                      : GestureDetector(
                        onTap: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setBool('isFirstTime', false);
                          Navigator.pushReplacementNamed(context, homeLayout);
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColor.backgroundColor,
                          radius: 30.r,
                          child: Icon(
                            Icons.arrow_forward,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeLanguage,
        child: Icon(Icons.language),
      ),
    );
  }
}
