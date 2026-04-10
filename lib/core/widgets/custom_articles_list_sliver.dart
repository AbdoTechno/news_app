import 'dart:math';
import 'package:flutter/material.dart';
import 'package:news/core/enums/request_status_enums.dart';
import 'package:news/core/extension/date_time_extension.dart';
import 'package:news/core/widgets/custom_cached_networkImage.dart';
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
            borderRadius: 0,
            itemCount: shimmerItemCount,
            scrollDirection: Axis.vertical,
            padding: padding,
            separatorSize: 8,
          ),
        );

      case RequestStatusEnums.success:
        return SliverList.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final news = articles[index];
            return _ArticleCard(
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
class _ArticleCard extends StatelessWidget {
  final NewsArticleModel article;
  final EdgeInsetsGeometry padding;
  final double imageWidth;
  final double imageHeight;
  final VoidCallback? onBookmarkTap;
  final Function(NewsArticleModel)? onArticleTap;

  const _ArticleCard({
    required this.article,
    required this.padding,
    required this.imageWidth,
    required this.imageHeight,
    this.onBookmarkTap,
    this.onArticleTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onArticleTap?.call(article),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomCachedNetworkImage(
                imageUrl: article.urlToImage ?? "",
                width: imageWidth,
                height: imageHeight,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 2,
                    article.title ?? "",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    children: [
                      article.urlToImage != null
                          ? CircleAvatar(
                              radius: 10,
                              backgroundImage: NetworkImage(article.urlToImage!),
                            )
                          : Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                            ),
                      const SizedBox(width: 8),
                      Text(
                        "${(article.author ?? "").substring(0, min((article.author ?? "").length, 10))}...",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.color?.withOpacity(0.6),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        article.publishedAt.formatDate(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.color?.withOpacity(0.6),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: onBookmarkTap,
                        child: Icon(
                          Icons.bookmark_border_outlined,
                          size: 25,
                          color: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.color?.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
