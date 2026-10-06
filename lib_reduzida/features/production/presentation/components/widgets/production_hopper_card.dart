import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:web_analise_app/features/production/domain/entities/hopper_entity.dart';
import 'package:web_analise_app/features/production/presentation/components/widgets/iconed_info_text.dart';
import 'package:web_analise_app/features/production/presentation/components/widgets/info_text.dart';
import 'package:web_analise_app/features/production/presentation/components/widgets/production_page/production_hopper_actions_modal.dart';
import 'package:web_analise_app/shared/constants/app_icons.dart';
import 'package:web_analise_app/shared/constants/app_strings.dart';
import 'package:web_analise_app/shared/themes/helpers/app_border_radius.dart';
import 'package:web_analise_app/shared/themes/helpers/app_insets.dart';
import 'package:web_analise_app/shared/themes/helpers/app_shadows.dart';
import 'package:web_analise_app/shared/themes/helpers/app_spacing.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';
import 'package:web_analise_app/shared/themes/tokens/app_icon_sizes.dart';
import 'package:web_analise_app/shared/utils/formatters/weight_formatter.dart';
import 'package:web_analise_app/shared/widgets/rounded_icon_background.dart';

class ProductionHopperCard extends StatelessWidget {
  final HopperEntity hopper;
  final VoidCallback onCancel;
  final VoidCallback onTapEmptyHopper;
  final VoidCallback onTapCleaningHopper;

  const ProductionHopperCard({
    super.key,
    required this.hopper,
    required this.onCancel,
    required this.onTapEmptyHopper,
    required this.onTapCleaningHopper,
  });

  static const String emptyStatus = 'is_empty';

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.colors.primary;

    final statusName = switch (hopper.status) {
      AppStrings.hopperInUse => 'EM USO',
      AppStrings.hopperEmpty => 'LIVRE',
      _ => AppStrings.unknownStatus,
    };

    final statusColor = switch (hopper.status) {
      AppStrings.hopperInUse => primaryColor,
      AppStrings.hopperEmpty => const Color(0xFFE17E02),
      _ => context.colors.outline,
    };

    return GestureDetector(
      onTap: () => ProductionHopperActionsModal.show(
        context: context,
        hopper: hopper,
        statusName: statusName,
        primaryColor: primaryColor,
        statusColor: statusColor,
        onCancel: onCancel,
        onTapEmptyHopper: onTapEmptyHopper,
        onTapCleaningHopper: onTapCleaningHopper,
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: context.colors.surfaceContainerLowest,
          boxShadow: AppShadows.softContainerShadow,
          borderRadius: hopper.status == AppStrings.hopperInUse
              ? AppBorderRadius.allLarge
              : AppBorderRadius.topLarge,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 60,
              color: primaryColor,
              child: Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Row(
                  children: [
                    AppSpacing.hLarge,
                    Expanded(
                      child: Text(
                        hopper.hopperName,
                        style: context.texts.headlineSmall!.copyWith(
                          color: context.colors.onPrimary,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    AppSpacing.hLarge,
                  ],
                ),
              ),
            ),
            // --- CARD BODY ---
            hopper.status != emptyStatus
                ? Padding(
                    padding: AppInsets.hLarge,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSpacing.vExtraLarge,
                        InfoText(
                          infoName: 'Produtor',
                          infoValue: hopper.growerName ?? 'Nome do Produtor',
                          secondInfoValue:
                              hopper.memberName ?? 'Nome do cooperado',
                        ),
                        AppSpacing.vLarge,
                        Container(
                          height: 1,
                          color: context.colors.outlineVariant,
                        ),
                        AppSpacing.vLarge,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InfoText(
                              infoName: 'Cultivar',
                              infoValue: hopper.varietyName ?? 'ABCDE',
                            ),
                            InfoText(
                              infoName: 'Categoria',
                              infoValue: hopper.varietyName ?? 'XX',
                            ),
                          ],
                        ),
                        AppSpacing.vExtraLarge,
                      ],
                    ),
                  )
                : Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundedIconBackground(
                          iconPath: AppIcons.hopper,
                          iconColor: primaryColor,
                          iconSize: AppIconSizes.large,
                          backgroundSize: AppIconSizes.largeBackground,
                          backgroundColor: primaryColor.withAlpha(38),
                        ),
                        AppSpacing.vMedium,
                        Text(
                          'Livre',
                          style: context.texts.headlineSmall!.copyWith(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AppSpacing.vExtraSmall,
                        Text(
                          'Moega disponível\n para recebimento',
                          style: context.texts.bodyMedium!.copyWith(
                            height: 0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
            // --- CARD FOOTER ---
            hopper.status != emptyStatus
                ? Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(38),
                        borderRadius: AppBorderRadius.bottomLarge,
                      ),
                      child: Padding(
                        padding: AppInsets.hLarge,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: AppIconSizes.medium,
                                  width: AppIconSizes.medium,
                                  child: Image.asset(AppIcons.filledTruck),
                                ),
                                AppSpacing.hSmall,
                                Text(
                                  hopper.totalLoads.toString(),
                                  style: context.texts.headlineSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AppSpacing.hSmall,
                                Text(
                                  'Cargas\nRecebidas',
                                  style: context.texts.bodySmall!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 60,
                              width: 1,
                              color: context.colors.outlineVariant,
                            ),
                            IconedInfoText(
                              icon: AppIcons.scale,
                              iconColor: primaryColor,
                              infoName: 'Total:',
                              infoValue: WeightFormatter.format(
                                hopper.totalWeight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : DottedLine(
                    dashColor: primaryColor,
                    dashGapLength: 8,
                    dashLength: 8,
                    lineThickness: 3,
                  ),
          ],
        ),
      ),
    );
  }
}
