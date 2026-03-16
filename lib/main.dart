import 'package:flutter/material.dart';
import 'package:news/core/datasource/local_data/preferences_manager.dart';
import 'package:news/core/theme/light_theme.dart';
import 'package:news/features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,

      // theme: darkTheme,
      home: SplashScreen(),
    );
  }
}
