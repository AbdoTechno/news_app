import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  final List<String> categories = [
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology",
  ];

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedCategory == categories[index];
          return InkWell(
            onTap: () {
              setState(() {
                selectedCategory = categories[index];
              });
            },
            child: IntrinsicWidth(
              child: Column(
                children: [
                  Text(
                    categories[index],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (isSelected) ...[
                    SizedBox(height: 4),
                    Container(
                      height: 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 12);
        },
      ),
    );
  }
}
