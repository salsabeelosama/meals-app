import 'package:depi_project/core/app_color.dart';
import 'package:depi_project/features/home/data/db_helper.dart';
import 'package:depi_project/features/home/data/meal_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddMealScreen extends StatefulWidget {
  AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final TextEditingController? mealController = TextEditingController();
  final TextEditingController? rateController = TextEditingController();
  final TextEditingController? timeController = TextEditingController();
  final TextEditingController? descriptionController = TextEditingController();
  final TextEditingController? imageurlController = TextEditingController();
  final TextEditingController? caloriesController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  DatabaseHelper db = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.backgroundColor,
          flexibleSpace: Container(color: AppColor.backgroundColor),
          title: Text(
            "add_meal".tr(),
            style: TextStyle(color: AppColor.textColor, fontSize: 22.sp),
          ),
          centerTitle: true,
          surfaceTintColor: AppColor.backgroundColor,
        ),
        backgroundColor: AppColor.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'meal_name'.tr()),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    controller: mealController,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "The Form Cannot Be Empty";
                      }
                    },
                  ),
                  SizedBox(height: 8.h),
                  CustomText(text: 'image_url'.tr()),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    maxlines: 3,
                    controller: imageurlController,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "The Form Cannot Be Empty";
                      }
                    },
                  ),
                  SizedBox(height: 8.h),
                  CustomText(text: 'rate'.tr()),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    controller: rateController,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "The Form Cannot Be Empty";
                      }
                    },
                  ),
                  SizedBox(height: 8.h),
                  CustomText(text: 'calories'.tr()),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    controller: caloriesController,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "The Form Cannot Be Empty";
                      }
                    },
                  ),
                  SizedBox(height: 8.h),
                  CustomText(text: 'time'.tr()),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    controller: timeController,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "The Form Cannot Be Empty";
                      }
                    },
                  ),
                  SizedBox(height: 8.h),
                  CustomText(text: 'description'.tr()),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    maxlines: 5,
                    controller: descriptionController,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "The form cannot be empty please enter ";
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: SizedBox(
                      width: 327.w,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            MealModel meal = MealModel(
                              name: mealController!.text,
                              imageUrl: imageurlController!.text,
                              calories: double.parse(caloriesController!.text),
                              description: descriptionController!.text,
                              time: timeController!.text,
                              rate: double.parse(rateController!.text),
                            );
                            db.insertMeal(meal).then((_) {
                              mealController!.clear();
                              imageurlController!.clear();
                              caloriesController!.clear();
                              descriptionController!.clear();
                              timeController!.clear();
                              rateController!.clear();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                        ),
                        child: Text(
                          "save".tr(),
                          style: TextStyle(
                            color: AppColor.backgroundColor,
                            fontSize: 22.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColor.textColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.maxlines,

    required this.controller,
    this.validator,
  });
  final int? maxlines;
  //  final int? maxlength;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: AppColor.textColor),
      validator: validator,
      controller: controller,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      // maxLength: maxlength ?? 10,
      maxLines: maxlines ?? 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 85, 144, 245),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColor.subColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
