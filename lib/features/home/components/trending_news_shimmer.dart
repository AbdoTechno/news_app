import 'package:flutter/material.dart';
import 'package:news/core/sizes/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class TrendingNewsShimmer extends StatelessWidget {
  const TrendingNewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 16),
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: AppSizes.spacingWidth280,
            height: AppSizes.spacingHeight170,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
              color: Colors.grey.shade300,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(width: AppSizes.spacingWidth16),
    );
  }
}
