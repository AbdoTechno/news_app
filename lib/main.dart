import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/datasource/local_data/preferences_manager.dart';
import 'package:news/core/theme/light_theme.dart';
import 'package:news/features/splash/splash_screen.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();

  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();
  // PreferencesManager().clear();

  runApp(const MyApp());
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
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News',
        theme: lightTheme,
        // theme: darkTheme,
        home: SplashScreen(),
      ),
    );
  }
}
