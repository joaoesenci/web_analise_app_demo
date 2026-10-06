import 'package:flutter/material.dart';
import 'package:web_analise_app/shared/themes/helpers/app_border_radius.dart';
import 'package:web_analise_app/shared/themes/helpers/app_spacing.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';
import 'package:web_analise_app/shared/themes/tokens/app_icon_sizes.dart';

class ProductionNavigationBarItem extends StatelessWidget {
  final String icon;
  final String text;
  final bool isSelected;
  final VoidCallback onChangePage;

  const ProductionNavigationBarItem({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.text,
    required this.onChangePage,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.colors.primary;
    final surfaceColor = context.colors.surface;

    return Expanded(
      child: GestureDetector(
        onTap: onChangePage,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? surfaceColor : primaryColor,
            borderRadius: AppBorderRadius.topExtraLarge,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: AppIconSizes.small,
                child: Image.asset(
                  icon,
                  color: isSelected ? primaryColor : surfaceColor,
                ),
              ),
              AppSpacing.hMedium,
              Text(
                text,
                style: context.texts.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? primaryColor : surfaceColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
