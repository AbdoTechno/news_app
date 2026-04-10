import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Generic reusable shimmer loading widget for list items
class CustomShimmerLoader extends StatelessWidget {
  final int itemCount;
  final double width;
  final double height;
  final double borderRadius;
  final Axis scrollDirection;
  final EdgeInsetsGeometry padding;
  final double separatorSize;
  final Color? baseColor;
  final Color? highlightColor;
  final ScrollPhysics? physics;

  const CustomShimmerLoader({
    super.key,
    this.itemCount = 5,
    this.width = 280,
    this.height = 170,
    this.borderRadius = 12,
    this.scrollDirection = Axis.horizontal,
    this.padding = const EdgeInsets.all(0),
    this.separatorSize = 16,
    this.baseColor,
    this.highlightColor,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    final baseColorValue = baseColor ?? Colors.grey.shade300;
    final highlightColorValue = highlightColor ?? Colors.grey.shade100;

    // Use Column for vertical layouts (works better in slivers)
    if (scrollDirection == Axis.vertical) {
      return Padding(
        padding: padding,
        child: Column(
          children: List.generate(
            itemCount,
            (index) => Column(
              children: [
                Shimmer.fromColors(
                  baseColor: baseColorValue,
                  highlightColor: highlightColorValue,
                  child: Container(
                    width: double.infinity,
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      color: baseColorValue,
                    ),
                  ),
                ),
                if (index < itemCount - 1) SizedBox(height: separatorSize),
              ],
            ),
          ),
        ),
      );
    }

    // Use ListView for horizontal layouts
    return ListView.separated(
      padding: padding,
      scrollDirection: scrollDirection,
      itemCount: itemCount,
      shrinkWrap: true,
      physics: physics ?? const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: baseColorValue,
          highlightColor: highlightColorValue,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: baseColorValue,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(width: separatorSize),
    );
  }
}
