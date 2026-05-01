import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/core/sizes/app_sizes.dart';
import 'package:news/core/theme/app_colors.dart';

class ProfileOptionWidget extends StatelessWidget {
  const ProfileOptionWidget({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.trailingIcon,
    this.onTap,
    this.showDivider = true,
  });
  final String title;
  final String leadingIcon;
  final String trailingIcon;
  final VoidCallback? onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizes.spacingHeight12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      leadingIcon,
                      width: AppSizes.iconSize20,
                      height: AppSizes.iconSize20,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: AppSizes.spacingWidth8),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: AppSizes.fontSize20,
                        color: showDivider ? AppColors.iconColor : AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  trailingIcon,
                  width: AppSizes.iconSize16,
                  height: AppSizes.iconSize16,
                  fit: BoxFit.contain,
                  colorFilter: showDivider
                      ? null
                      : const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                ),
              ],
            ),
          ),
        ),
        showDivider ? Divider(height: 1, thickness: 1) : SizedBox.shrink(),
      ],
    );
  }
}
