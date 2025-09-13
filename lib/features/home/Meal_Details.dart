import 'package:cached_network_image/cached_network_image.dart';
import 'package:depi_project/core/app_color.dart';
import 'package:depi_project/features/home/data/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealDetails extends StatelessWidget {
  MealDetails({super.key, required this.meal});

  MealModel meal;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Description",
          style: TextStyle(
            color: AppColor.textColor,
            fontSize: 26.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            width: size.width,
            child: CachedNetworkImage(
              imageUrl: meal.imageUrl,
              height: 200.h,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: Text(
                    meal.name,
                    style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Icon(Icons.timer, color: AppColor.primaryColor),
                    Text(
                      meal.rate.toString(),
                      style: TextStyle(
                        color: AppColor.subColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 210.w),
                    Icon(Icons.star, color: AppColor.primaryColor),
                    Text(
                      meal.time,
                      style: TextStyle(
                        color: AppColor.subColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  meal.description,
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
