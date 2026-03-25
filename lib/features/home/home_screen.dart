import 'package:flutter/material.dart';
import 'package:news/features/home/components/CategoriesList.dart';
import 'package:news/features/home/components/trending_news.dart';
import 'package:news/features/home/components/view_all.dart';
import 'package:news/features/home/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return HomeController()..init();
      },
      child: Consumer<HomeController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Scaffold(
            body: Column(
              children: [
                TrendinagNews(),
                const SizedBox(height: 12),
                ViewAll(
                  title: "Categories",
                  color:
                      Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
                ),
                CategoriesList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
