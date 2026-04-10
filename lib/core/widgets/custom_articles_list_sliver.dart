import 'package:flutter/material.dart';
import 'package:news/core/enums/request_status_enums.dart';
import 'package:news/core/sizes/app_sizes.dart';
import 'package:news/core/widgets/artical_card.dart';
import 'package:news/core/widgets/custom_shimmer_loader.dart';
import 'package:news/features/home/models/news_article_model.dart';

/// Generic reusable articles sliver widget
class CustomArticlesListSliver extends StatelessWidget {
  final RequestStatusEnums requestStatus;
  final List<NewsArticleModel> articles;
  final String? errorMessage;
  final VoidCallback? onBookmarkTap;
  final Function(NewsArticleModel)? onArticleTap;
  final int shimmerItemCount;
  final EdgeInsetsGeometry padding;
  final double imageWidth;
  final double imageHeight;

  const CustomArticlesListSliver({
    super.key,
    required this.requestStatus,
    required this.articles,
    this.errorMessage,
    this.onBookmarkTap,
    this.onArticleTap,
    this.shimmerItemCount = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
    this.imageWidth = 150,
    this.imageHeight = 90,
  });

  @override
  Widget build(BuildContext context) {
    switch (requestStatus) {
      case RequestStatusEnums.loading:
        return SliverToBoxAdapter(
          child: CustomShimmerLoader(
            height: imageHeight,
            width: imageWidth,
            borderRadius: AppSizes.borderRadius0,
            itemCount: shimmerItemCount,
            scrollDirection: Axis.vertical,
            padding: padding,
            separatorSize: AppSizes.spacingHeight8,
          ),
        );

      case RequestStatusEnums.success:
        return SliverList.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final news = articles[index];
            return ArticleCard(
              article: news,
              padding: padding,
              imageWidth: imageWidth,
              imageHeight: imageHeight,
              onBookmarkTap: onBookmarkTap,
              onArticleTap: onArticleTap,
            );
          },
        );

      case RequestStatusEnums.error:
        return SliverToBoxAdapter(
          child: Center(child: Text(errorMessage ?? 'An error occurred')),
        );
    }
  }
}

/// Individual article card widget
