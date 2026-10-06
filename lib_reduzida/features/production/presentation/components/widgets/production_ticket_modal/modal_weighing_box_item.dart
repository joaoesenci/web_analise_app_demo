import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_analise_app/shared/themes/helpers/app_border_radius.dart';
import 'package:web_analise_app/shared/themes/helpers/app_insets.dart';
import 'package:web_analise_app/shared/themes/helpers/app_spacing.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';
import 'package:web_analise_app/shared/themes/tokens/app_icon_sizes.dart';
import 'package:web_analise_app/shared/utils/formatters/moisture_input_formatter.dart';
import 'package:web_analise_app/shared/utils/formatters/weight_input_formatter.dart';
import 'package:web_analise_app/shared/widgets/rounded_icon_background.dart';

class ModalWeighingBoxItem extends StatelessWidget {
  final String icon;
  final String title;
  final double? customIconSize;
  final TextEditingController controller;
  final bool isMoisture;

  const ModalWeighingBoxItem({
    super.key,
    required this.icon,
    required this.title,
    this.customIconSize,
    required this.controller,
    this.isMoisture = false,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.colors.primary;
    final outlineVariantColor = context.colors.outlineVariant;
    final bodyLargeText = context.texts.bodyLarge;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.outline, width: 0.5),
        borderRadius: AppBorderRadius.allMedium,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedIconBackground(
              iconPath: icon,
              iconSize: customIconSize ?? AppIconSizes.medium,
              iconColor: primaryColor,
              backgroundSize: AppIconSizes.mediumBackground,
              backgroundColor: primaryColor.withAlpha(30),
            ),
            AppSpacing.hMedium,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.texts.bodySmall),
                AppSpacing.vSmall,
                Container(
                  height: 54,
                  width: 240,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    border: Border.all(color: outlineVariantColor),
                    borderRadius: AppBorderRadius.allSmall,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: AppInsets.hMedium,
                          child: TextField(
                            controller: controller,
                            textAlign: TextAlign.end,
                            keyboardType: TextInputType.number,
                            maxLength: isMoisture ? 4 : 6,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            inputFormatters: [
                              isMoisture
                                  ? MoistureInputFormatter()
                                  : WeightInputFormatter(),
                            ],
                            style: bodyLargeText!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 54,
                        width: 40,
                        color: outlineVariantColor.withAlpha(50),
                        child: Center(
                          child: Text(
                            isMoisture ? '%' : 'kg',
                            style: bodyLargeText.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
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
