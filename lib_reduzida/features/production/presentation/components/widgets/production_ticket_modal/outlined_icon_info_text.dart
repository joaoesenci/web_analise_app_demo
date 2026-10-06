import 'package:flutter/material.dart';
import 'package:web_analise_app/shared/themes/helpers/app_border_radius.dart';
import 'package:web_analise_app/shared/themes/helpers/app_spacing.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';
import 'package:web_analise_app/shared/themes/tokens/app_icon_sizes.dart';

class OutlinedIconInfoText extends StatelessWidget {
  final String infoName;
  final String infoValue;
  final String icon;

  const OutlinedIconInfoText({
    super.key,
    required this.infoName,
    required this.infoValue,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: context.colors.outline, width: 0.5),
          borderRadius: AppBorderRadius.allSmall,
        ),

        child: Row(
          children: [
            AppSpacing.hLarge,
            Container(
              height: AppIconSizes.extraSmallBackground,
              width: AppIconSizes.extraSmallBackground,
              decoration: BoxDecoration(
                color: context.colors.primary.withAlpha(30),
                borderRadius: AppBorderRadius.allSmall,
              ),
              child: Center(
                child: SizedBox(
                  height: AppIconSizes.small,
                  width: AppIconSizes.small,
                  child: Image.asset(icon),
                ),
              ),
            ),
            AppSpacing.hMedium,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(infoName, style: context.texts.bodyMedium),
                Text(
                  infoValue,
                  maxLines: 1,
                  style: context.texts.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
