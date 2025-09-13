import 'package:depi_project/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void changelanguage() {
      if (context.locale == Locale('en')) {
        context.setLocale(Locale('ar'));
      } else {
        context.setLocale(Locale('en'));
      }
    }

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        title: Text(
          "my_profile".tr(),
          style: TextStyle(
            color: AppColor.textColor,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40.h),
            CircleAvatar(
              radius: 70.r,
              backgroundImage: AssetImage("assets/images/selfie_cat.jpg"),
            ),
            SizedBox(height: 20.h),
            Text(
              "Sasso",
              style: TextStyle(
                color: AppColor.textColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'change_language'.tr(),
                    style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      changelanguage();
                    },
                    icon: Icon(Icons.language),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
