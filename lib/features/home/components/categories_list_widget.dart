import 'package:flutter/material.dart';
import 'package:news/core/sizes/app_sizes.dart';
import 'package:news/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesListWidget extends StatelessWidget {
  CategoriesListWidget({super.key});

  final List<String> categories = [
    "Top News",
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.spacingHeight40,
      child: Consumer<HomeController>(
        builder: (BuildContext context, HomeController controller, Widget? child) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.spacingWidth16),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              bool isSelected = controller.selectedCategory == categories[index];
              return InkWell(
                onTap: () {
                  controller.updateSelectedCategory(categories[index]);
                },
                child: IntrinsicWidth(
                  child: Column(
                    children: [
                      Text(
                        categories[index],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      SizedBox(height: AppSizes.spacingHeight4),
                      Container(
                        height: AppSizes.spacingHeight2,
                        width: isSelected ? null : 0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadius12,
                          ),
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: AppSizes.spacingWidth12);
            },
          );
        },
      ),
    );
  }
}
