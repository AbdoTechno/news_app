import 'package:flutter/material.dart';
import 'package:news/core/datasource/remote_data/api_service.dart';
import 'package:news/features/home/categories_screen.dart';
import 'package:news/features/home/components/categories_list_widget.dart';
import 'package:news/features/home/components/top_headLines_list.dart';
import 'package:news/features/home/components/trending_news.dart';
import 'package:news/features/home/components/view_all.dart';
import 'package:news/features/home/controllers/home_controller.dart';
import 'package:news/core/repos/news_repository.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return HomeController(NewsRepository(ApiService()))..init();
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
                    screen: ChangeNotifierProvider.value(
                      value: controller,
                      child: CategoriesScreen(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: CategoriesListWidget()),
                TopHeadlinesList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
