import 'package:flutter/material.dart';
import 'package:news/features/home/components/CategoriesList.dart';
import 'package:news/features/home/components/top_headLines_list.dart';
import 'package:news/features/home/components/trending_news.dart';
import 'package:news/features/home/components/view_all.dart';
import 'package:news/features/home/controllers/home_controller.dart';
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
            body: CustomScrollView(
              slivers: [
                TrendinagNews(),
                SliverToBoxAdapter(
                  child: ViewAll(
                    title: "Categories",
                    color:
                        Theme.of(context).textTheme.bodyMedium?.color ??
                        Colors.black,
                  ),
                ),
                CategoriesList(),
                TopHeadlinesList(),
              ],
            ),
          );
        },
      ),
    );
  }
}

