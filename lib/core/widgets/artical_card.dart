import 'package:flutter/material.dart';
import 'package:news/core/extension/date_time_extension.dart';
import 'package:news/core/sizes/app_sizes.dart';
import 'package:news/core/widgets/custom_cached_networkImage.dart';
import 'package:news/features/details/details_screen.dart';
import 'package:news/features/home/models/news_article_model.dart';

class ArticleCard extends StatelessWidget {
  final NewsArticleModel article;
  final EdgeInsetsGeometry padding;
  final double imageWidth;
  final double imageHeight;
  final VoidCallback? onBookmarkTap;
  final Function(NewsArticleModel)? onArticleTap;

  const ArticleCard({
    super.key,
    required this.article,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
    this.imageWidth = 150,
    this.imageHeight = 90,
    this.onBookmarkTap,
    this.onArticleTap,
  });

  @override
  Widget build(BuildContext context) {
    final author = (article.author ?? "").trim();
    final authorPreview = author.length > 10
        ? "${author.substring(0, 10)}..."
        : author;

    return GestureDetector(
      onTap: () =>Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(model : article),
        ),
      ),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius8),
              child: CustomCachedNetworkImage(
                imageUrl: article.urlToImage ?? "",
                width: imageWidth,
                height: imageHeight,
              ),
            ),
            SizedBox(width: AppSizes.spacingWidth8),
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
                              radius: AppSizes.borderRadius10,
                              backgroundImage: NetworkImage(article.urlToImage!),
                            )
                          : Container(
                              width: AppSizes.size20,
                              height: AppSizes.size20,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                            ),
                      SizedBox(width: AppSizes.spacingWidth8),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                authorPreview,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color
                                          ?.withOpacity(0.6),
                                    ),
                              ),
                            ),
                            SizedBox(width: AppSizes.spacingWidth8),
                            Text(
                              article.publishedAt.formatDate(),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                overflow: TextOverflow.ellipsis,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color?.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: AppSizes.spacingWidth8),
                      GestureDetector(
                        onTap: onBookmarkTap,
                        child: Icon(
                          Icons.bookmark_border_outlined,
                          size: AppSizes.iconSize25,
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
