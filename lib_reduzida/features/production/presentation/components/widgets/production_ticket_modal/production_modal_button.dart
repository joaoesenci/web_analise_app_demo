import 'package:flutter/material.dart';
import 'package:web_analise_app/shared/themes/helpers/app_border_radius.dart';
import 'package:web_analise_app/shared/themes/helpers/app_insets.dart';
import 'package:web_analise_app/shared/themes/helpers/app_spacing.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';
import 'package:web_analise_app/shared/themes/tokens/app_icon_sizes.dart';
import 'package:web_analise_app/shared/widgets/rounded_icon_background.dart';

class ProductionModalButton extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final String icon;
  final VoidCallback onPressed;

  const ProductionModalButton({
    super.key,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 82,
        padding: AppInsets.hLarge,
        decoration: BoxDecoration(
          color: color.withAlpha(27),
          border: Border.all(color: color.withAlpha(127), width: 1.5),
          borderRadius: AppBorderRadius.allSmall,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RoundedIconBackground(
                  iconPath: icon,
                  iconSize: AppIconSizes.small,
                  backgroundSize: AppIconSizes.smallBackground,
                  backgroundColor: color,
                ),
                AppSpacing.hLarge,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.texts.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(description, style: context.texts.bodyMedium),
                  ],
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios_outlined, color: color),
          ],
        ),
      ),
    );
  }
}
