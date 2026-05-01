import 'package:flutter/material.dart';
import 'package:news/core/extension/date_time_extension.dart';
import 'package:news/core/sizes/app_sizes.dart';
import 'package:news/core/widgets/custom_cached_networkImage.dart';
import 'package:news/features/home/models/news_article_model.dart';

class DetailsScreen extends StatelessWidget {
  final NewsArticleModel model;

  const DetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Details')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.paddingHorizontal16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
                child: CustomCachedNetworkImage(
                  imageUrl: model.urlToImage ?? "",
                  height: 230,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: AppSizes.spacingHeight16),
              Text(
                model.title ?? "",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: AppSizes.fontSize20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: AppSizes.spacingHeight8),
              Row(
                children: [
                  model.urlToImage != null
                      ? CircleAvatar(
                          radius: AppSizes.borderRadius16,
                          backgroundImage: NetworkImage(model.urlToImage!),
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
                            model.author ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color?.withOpacity(0.6),
                            ),
                          ),
                        ),
                        SizedBox(width: AppSizes.spacingWidth8),
                        Text(
                          model.publishedAt.formatDate(),
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
                    onTap: () {},
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
              SizedBox(height: AppSizes.spacingHeight16),
              Text(
                model.content ?? "",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
