import 'package:depi_project/core/app_color.dart';
import 'package:depi_project/features/home/Home_Screen.dart';
import 'package:depi_project/features/home/Profile_Screen.dart';
import 'package:depi_project/features/home/add_meal_Screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({super.key});

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  List<Widget> screens = [HomeScreen() , AddMealScreen() , ProfileScreen()];
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.backgroundColor,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: AppColor.textColor,
        currentIndex: currentindex,
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svg/home_non.svg'),
            activeIcon: SvgPicture.asset('assets/svg/home_active.svg'),
            label: 'home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svg/add_meal_non.svg'),
            activeIcon: SvgPicture.asset('assets/svg/add_meal_active.svg'),
            label: "add_meal".tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svg/profile_non.svg'),
            activeIcon: SvgPicture.asset('assets/svg/profile_active.svg'),
            label: 'profile'.tr(),
          ),
        ],
      ),
    );
  }
}
