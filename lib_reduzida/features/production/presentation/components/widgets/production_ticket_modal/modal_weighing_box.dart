import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_analise_app/features/production/presentation/components/widgets/production_page/production_ticket_modal/modal_weighing_box_item.dart';
import 'package:web_analise_app/features/production/presentation/components/widgets/production_page/production_ticket_modal/modal_weighing_iconed_text.dart';
import 'package:web_analise_app/shared/constants/app_icons.dart';
import 'package:web_analise_app/shared/themes/helpers/app_border_radius.dart';
import 'package:web_analise_app/shared/themes/helpers/app_spacing.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';
import 'package:web_analise_app/shared/themes/tokens/app_icon_sizes.dart';
import 'package:web_analise_app/shared/themes/tokens/app_sizes.dart';
import 'package:web_analise_app/shared/utils/formatters/weight_formatter.dart';
import 'package:web_analise_app/shared/widgets/rounded_icon_background.dart';

class ModalWeighingBox extends StatelessWidget {
  final TextEditingController grossWeightController;
  final TextEditingController tareWeightController;
  final TextEditingController impurityWeightController;
  final TextEditingController moistureController;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const ModalWeighingBox({
    super.key,
    required this.grossWeightController,
    required this.tareWeightController,
    required this.impurityWeightController,
    required this.moistureController,
    required this.onCancel,
    required this.onSave,
  });

  String _calculateNetWeight(String gross, String tare, String impurity) {
    if (gross.isNotEmpty && tare.isNotEmpty && impurity.isNotEmpty) {
      final grossWeight = int.tryParse(gross.replaceAll('.', ''));
      final tareWeight = int.tryParse(tare.replaceAll('.', ''));
      final impurityWeight = int.tryParse(impurity.replaceAll('.', ''));
      final netWeight = grossWeight! - tareWeight! - impurityWeight!;

      return WeightFormatter.format(netWeight);
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = context.keyboardHeight;
    final keyboardIsActive = keyboardHeight > 0;
    final primaryColor = context.colors.primary;
    final bodyLargeText = context.texts.bodyLarge;
    final summaryWidth = context.screenWidth * 0.93;
    final netWeight = _calculateNetWeight(
      grossWeightController.text,
      tareWeightController.text,
      impurityWeightController.text,
    );

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: keyboardHeight),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                mainAxisSpacing: AppSizes.large,
                crossAxisSpacing: AppSizes.large,
                children: [
                  ModalWeighingBoxItem(
                    icon: AppIcons.loadedTrck,
                    title: 'Peso Bruto (kg)',
                    controller: grossWeightController,
                  ),
                  ModalWeighingBoxItem(
                    icon: AppIcons.unloadedTruck,
                    title: 'Peso Tara (kg)',
                    controller: tareWeightController,
                  ),
                  ModalWeighingBoxItem(
                    icon: AppIcons.imputiry,
                    title: 'Impureza (kg)',
                    controller: impurityWeightController,
                  ),
                  ModalWeighingBoxItem(
                    icon: AppIcons.dropWater,
                    title: 'Umidade (%)',
                    customIconSize: 28.0,
                    controller: moistureController,
                    isMoisture: true,
                  ),
                ],
              ),
              if (!keyboardIsActive) ...[
                AppSpacing.vExtraLarge,
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(15),
                    border: Border.all(
                      color: context.colors.outline,
                      width: 0.5,
                    ),
                    borderRadius: AppBorderRadius.allMedium,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: summaryWidth / 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedIconBackground(
                              iconPath: AppIcons.summary,
                              iconSize: AppIconSizes.largeBackground,
                              iconColor: primaryColor,
                              backgroundSize: AppIconSizes.large,
                              backgroundColor: primaryColor.withAlpha(30),
                            ),
                            AppSpacing.hLarge,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Peso Líquido',
                                  style: bodyLargeText!.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AppSpacing.vSmall,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      netWeight.isNotEmpty ? netWeight : '0.0',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.texts.headlineMedium!
                                          .copyWith(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: AppSizes.medium,
                                        bottom: 3,
                                      ),
                                      child: Text(
                                        'kg',
                                        style: context.texts.titleLarge!
                                            .copyWith(
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 120,
                        width: 1,
                        color: context.colors.outlineVariant,
                      ),
                      SizedBox(
                        width: summaryWidth / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ModalWeighingIconedText(
                              title: 'Bruto:',
                              value: grossWeightController.text.isNotEmpty
                                  ? grossWeightController.text
                                  : '',
                            ),
                            AppSpacing.vMedium,
                            ModalWeighingIconedText(
                              title: 'Líquido:',
                              format: false,
                              value: _calculateNetWeight(
                                grossWeightController.text,
                                tareWeightController.text,
                                impurityWeightController.text,
                              ),
                            ),
                            AppSpacing.vMedium,
                            ModalWeighingIconedText(
                              title: 'Impureza:',
                              value: impurityWeightController.text.isNotEmpty
                                  ? impurityWeightController.text
                                  : '',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
