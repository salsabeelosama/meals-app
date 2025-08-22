import 'package:depi_project/features/home_layout/home_layout_Screen.dart';
import 'package:depi_project/features/home/Home_Screen.dart';
import 'package:depi_project/features/onboarding/onboarding_screen.dart';
import 'package:depi_project/features/onboarding/splash_Screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:depi_project/core/app_const.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translation',
      fallbackLocale: Locale('ar'),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
          initialRoute: splashScreen,

          routes: {
            splashScreen: (_) => SplashScreen(),
            onBoardingScreen: (_) => OnboardingScreen(),
            homeLayout:(_)=> HomeLayoutScreen()
          },
        );
      },

      //child: const FirstScreen(),
    );
  }
}
