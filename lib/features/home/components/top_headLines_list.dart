import 'package:flutter/material.dart';
import 'package:news/core/widgets/custom_articles_list_sliver.dart';
import 'package:news/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class TopHeadlinesList extends StatelessWidget {
  const TopHeadlinesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller, Widget? child) {
        final isTrendingNews = controller.selectedCategory == "Top News";
        return CustomArticlesListSliver(
          requestStatus: isTrendingNews
              ? controller.everythingRequestStatus
              : controller.topHeadLineRequestStatus,
          articles: isTrendingNews
              ? controller.everythingArticles
              : controller.topHeadLinesArticles,
          errorMessage: controller.errorMessage,
          onBookmarkTap: () {
            // TODO: Handle bookmark action
          },
        );
      },
    );
  }
}
