import 'package:carousel_slider/carousel_slider.dart';
import 'package:depi_project/core/app_color.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselSliderController sliderController = CarouselSliderController();
  int pageIndex = 0;
  List images = [
    Image.asset('assets/images/page1.png'),
    Image.asset('assets/images/page2.png'),
    Image.asset('assets/images/page3.png'),
  ];
  int currentindex = 0;

  List<Widget> listtitle = [
    ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/images/smothie.png'),
      ),
      title: Text(
        'breakfast_smoothie'.tr(),
        style: TextStyle(color: AppColor.textColor, fontSize: 18),
      ),
      subtitle: Text(
        '350_calories'.tr(),
        style: TextStyle(color: AppColor.primaryColor, fontSize: 16),
      ),
    ),
    ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/images/soup.png'),
      ),
      title: Text(
        'vegetable_soup'.tr(),
        style: TextStyle(color: AppColor.textColor, fontSize: 18),
      ),
      subtitle: Text(
        '600_calories'.tr(),
        style: TextStyle(color: AppColor.primaryColor, fontSize: 16),
      ),
    ),
    ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/images/chiken.png'),
      ),
      title: Text(
        'chicken_salad'.tr(),
        style: TextStyle(color: AppColor.textColor, fontSize: 18),
      ),
      subtitle: Text(
        '450_calories'.tr(),
        style: TextStyle(color: AppColor.primaryColor, fontSize: 16),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          title: Text(
            "my_meals".tr(),
            style: TextStyle(color: AppColor.textColor),
          ),
          centerTitle: true,
        ),
        body: Column(
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
                height: 200,
                disableCenter: true,
                viewportFraction: 1,
              ),
              items: List.generate(images.length, (index) {
                return Stack(
                  children: [
                    images[index],
                    SizedBox(height: 8.h),
                    Positioned(
                      bottom: 40,
                      left: 130,
                      child: DotsIndicator(
                        animate: true,
                        dotsCount: images.length,
                        position: pageIndex.toDouble(),
                        onTap: (index) {
                          debugPrint('$index');
                          sliderController.animateToPage(index);
                        },
                        decorator: DotsDecorator(
                          size: Size(26.w, 8.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          activeSize: Size(26.w, 8.h),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: AppColor.subColor, // Inactive color
                          activeColor: AppColor.backgroundColor,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "my_meals".tr(),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColor.textColor,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listtitle.length,
                itemBuilder: (context, index) {
                  return listtitle[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
