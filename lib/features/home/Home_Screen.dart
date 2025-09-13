import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:depi_project/core/app_color.dart';
import 'package:depi_project/features/home/Meal_Details.dart';
import 'package:depi_project/features/home/data/db_helper.dart';
import 'package:depi_project/features/home/data/meal_model.dart';
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
              child: FutureBuilder(
                future: DatabaseHelper.instance.getMeals(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Text("There is no data");
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        MealModel mealModel = snapshot.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => MealDetails(meal: mealModel),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.w),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(
                                  15.r,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data![index].imageUrl,
                                  height: 100.h,
                                  width: 100.w,
                                  fit: BoxFit.cover,
                                  errorWidget:
                                      (context, url, error) => Image.network(
                                        'https://uptownprinters.ca/assets/no_image_placeholder.png',
                                        height: 100.h,
                                        width: 100.w,
                                        fit: BoxFit.cover,
                                      ),
                                ),
                              ),
                              title: Text(snapshot.data![index].name),
                              subtitle: Text(
                                "${snapshot.data![index].calories.toString()} calories",
                                style: TextStyle(color: AppColor.primaryColor),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      "Something went wrong \n please try again later ",
                    );
                  }
                  return Text("Nothing returned");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
