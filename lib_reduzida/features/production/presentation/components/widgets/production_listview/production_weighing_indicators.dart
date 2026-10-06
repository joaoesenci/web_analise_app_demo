import 'package:flutter/material.dart';
import 'package:web_analise_app/shared/constants/app_icons.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';
import 'package:web_analise_app/shared/themes/themes.dart';
import 'package:web_analise_app/shared/widgets/app_asset.dart';
import 'package:web_analise_app/shared/widgets/texts/app_iconed_text.dart';

class ProductionWeighingIndicators extends StatelessWidget {
  final String moisture;
  final String grossWeight;
  final String netWeight;
  final bool showNetWeight;

  const ProductionWeighingIndicators({
    super.key,
    required this.moisture,
    required this.grossWeight,
    required this.netWeight,
    required this.showNetWeight,
  });

  @override
  Widget build(BuildContext context) {
    final nameTextStyle = context.texts.bodyMedium;
    final valueTextStyle = context.texts.titleLarge!.copyWith(
      fontWeight: FontWeight.bold,
      height: 0,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppIconedText(
              text: 'Umidade:',
              style: nameTextStyle,
              customSpacing: AppSpacing.hExtraSmall,
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: AppAsset(
                  path: AppIcons.dropWater,
                  size: AppIconSizes.extraSmall,
                ),
              ),
            ),
            Text(moisture, style: valueTextStyle),
          ],
        ),
        AppSpacing.vMedium,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppIconedText(
              text: 'Bruto:',
              style: nameTextStyle,
              customSpacing: AppSpacing.hExtraSmall,
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: AppAsset(
                  path: AppIcons.scale,
                  size: AppIconSizes.extraSmall,
                ),
              ),
            ),
            Text(grossWeight, style: valueTextStyle),
          ],
        ),
        AppSpacing.vMedium,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppIconedText(
              text: showNetWeight ? 'Líquido:' : '',
              style: nameTextStyle,
              customSpacing: AppSpacing.hExtraSmall,
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: showNetWeight
                    ? AppAsset(
                        path: AppIcons.scale,
                        size: AppIconSizes.extraSmall,
                      )
                    : SizedBox.shrink(),
              ),
            ),
            Text(showNetWeight ? netWeight : '', style: valueTextStyle),
          ],
        ),
      ],
    );
  }
}
