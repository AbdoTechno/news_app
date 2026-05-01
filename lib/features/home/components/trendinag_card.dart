import 'package:flutter/material.dart';
import 'package:news/core/extension/date_time_extension.dart';
import 'package:news/core/sizes/app_sizes.dart';
import 'package:news/core/widgets/custom_cached_networkImage.dart';
import 'package:news/features/details/details_screen.dart';
import 'package:news/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class TrendinagCard extends StatelessWidget {
  const TrendinagCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, HomeController controller, Widget? child) {
        return ListView.separated(
          padding: const EdgeInsets.only(left: 16),
          scrollDirection: Axis.horizontal,
          itemCount: controller.everythingArticles.take(5).length,
          itemBuilder: (context, index) {
            final model = controller.everythingArticles[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(model : model),
                  ),
                );
              }, 
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
                  border: Border.all(
                    width: AppSizes.borderWidth2,
                    color: Colors.white,
                  ),
                ),
                width: AppSizes.spacingWidth280,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      if (controller.everythingArticles[index].urlToImage != null)
                        CustomCachedNetworkImage(
                          imageUrl: model.urlToImage!,
                          width: AppSizes.spacingWidth280,
                          height: AppSizes.spacingHeight170,
                        ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.7),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        right: 12,
                        bottom: 12,
                        child: Column(
                          children: [
                            Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              model.title ?? '',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: AppSizes.fontSize14,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: AppSizes.borderRadius16,
                                  backgroundImage: model.urlToImage != null
                                      ? NetworkImage(model.urlToImage!)
                                      : Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                              ),
                                            )
                                            as ImageProvider,
                                ),
                                SizedBox(width: AppSizes.spacingWidth8),
                                Expanded(
                                  child: Text(
                                    model.author ?? 'Unknown Author',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                                SizedBox(width: AppSizes.spacingWidth8),
                                Text(
                                  model.publishedAt.formatDate(),
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
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
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: AppSizes.spacingWidth12);
          },
        );
      },
    );
  }
}
