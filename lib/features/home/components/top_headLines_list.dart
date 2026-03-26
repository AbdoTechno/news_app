import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news/core/extension/date_time_extension.dart';
import 'package:news/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class TopHeadlinesList extends StatelessWidget {
  const TopHeadlinesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (BuildContext context, HomeController controller, Widget? child) { 
      return  SliverList.builder(
        itemBuilder: (context, index) {
          final news = controller.topHeadLinesArticles[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    news.urlToImage ?? '',
                    width: 150,
                    height: 90,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Container(
                        width: 150,
                        height: 90,
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 150,
                        height: 90,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.broken_image, size: 40),
                        ),
                      );
                    },
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
                        news.title ?? "",
                        style: Theme.of(context).textTheme.bodyLarge
                            ?.copyWith(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Row(
                        children: [
                          news.urlToImage != null
                              ? CircleAvatar(
                                  radius: 10,
                                  backgroundImage: NetworkImage(
                                    news.urlToImage!,
                                  ),
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
                            "${(news.author ?? "").substring(0, min((news.author ?? "").length, 10))}...",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color
                                      ?.withOpacity(0.6),
                                  overflow: TextOverflow.ellipsis,
                                ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            news.publishedAt.formatDate(),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color
                                      ?.withOpacity(0.6),
                                ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.bookmark_border_outlined,
                            size: 25,
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.color
                                ?.withOpacity(0.6),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: controller.topHeadLinesArticles.length,
      ) ;
     },

    );
  }
}
