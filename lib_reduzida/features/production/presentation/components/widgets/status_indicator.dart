import 'package:flutter/material.dart';
import 'package:web_analise_app/shared/themes/helpers/app_border_radius.dart';
import 'package:web_analise_app/shared/themes/helpers/app_spacing.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';
import 'package:web_analise_app/shared/themes/tokens/app_colors.dart';
import 'package:web_analise_app/shared/themes/tokens/app_sizes.dart';

class StatusIndicator extends StatelessWidget {
  final String text;
  final bool isAlert;

  const StatusIndicator({super.key, required this.text, this.isAlert = false});

  @override
  Widget build(BuildContext context) {
    final widgetColor = isAlert ? AppColors.alertColor : context.colors.primary;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 1,
        horizontal: AppSizes.small,
      ),
      decoration: BoxDecoration(
        color: widgetColor.withAlpha(30),
        borderRadius: AppBorderRadius.allSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 7,
            width: 7,
            decoration: BoxDecoration(
              color: widgetColor,
              shape: BoxShape.circle,
            ),
          ),
          AppSpacing.hExtraSmall,
          Text(
            text,
            style: context.texts.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: widgetColor,
            ),
          ),
        ],
      ),
    );
  }
}
