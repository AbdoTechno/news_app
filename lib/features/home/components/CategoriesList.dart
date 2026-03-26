import 'package:flutter/material.dart';
import 'package:news/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {
  CategoriesList({super.key});

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
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 30,
        child: Consumer<HomeController>(
          builder: (BuildContext context, HomeController controller, Widget? child) {
            return ListView.separated(
              primary: false,
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        SizedBox(height: 4),
                        Container(
                          height: 2,
                          width: isSelected ? null : 0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 12);
              },
            );
          },
        ),
      ),
    );
  }
}
