import 'package:flutter/material.dart';
import 'package:web_analise_app/features/production/domain/entities/production_ticket_entity.dart';
import 'package:web_analise_app/features/production/presentation/components/widgets/info_text.dart';
import 'package:web_analise_app/features/production/presentation/components/widgets/production_page/production_listview/production_datetime_indicator.dart';
import 'package:web_analise_app/features/production/presentation/components/widgets/production_page/production_listview/production_weighing_indicators.dart';
import 'package:web_analise_app/shared/constants/app_strings.dart';
import 'package:web_analise_app/shared/themes/helpers/app_shadows.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';
import 'package:web_analise_app/shared/themes/themes.dart';
import 'package:web_analise_app/shared/themes/tokens/app_widgets_sizes.dart';
import 'package:web_analise_app/shared/utils/formatters/default_date_formatter.dart';
import 'package:web_analise_app/shared/utils/formatters/moisture_formatter.dart';
import 'package:web_analise_app/shared/utils/formatters/time_formatter.dart';
import 'package:web_analise_app/shared/utils/formatters/weight_formatter.dart';

class ProductionListviewItem extends StatelessWidget {
  final ProductionTicketEntity ticket;
  final VoidCallback onTap;

  const ProductionListviewItem({
    super.key,
    required this.ticket,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final outlineVariantColor = context.colors.outlineVariant;
    final bodyLargeText = context.texts.bodyLarge!;

    final ticketStatus = switch (ticket.status) {
      AppStrings.productionTicketCompleted => '',
      AppStrings.productionTicketAwaiting => 'Em processo',
      AppStrings.productionTicketInProgress => 'Descarregando',
      _ => AppStrings.unknownStatus,
    };

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.large,
          vertical: AppSizes.medium,
        ),
        decoration: BoxDecoration(
          color: context.colors.surfaceContainerLowest,
          boxShadow: AppShadows.softContainerShadow,
          borderRadius: AppBorderRadius.allLarge,
          border: Border.all(
            color: outlineVariantColor,
            width: AppWidgetSizes.borderWidth,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoText(
                        infoName: 'Ticket',
                        infoValue: ticket.number.toString(),
                        isLimited: true,
                      ),
                      InfoText(
                        infoName: 'Placa',
                        infoValue: ticket.plate,
                        isLimited: true,
                      ),
                      SizedBox(
                        width: 80,
                        child: ProductionDatetimeIndicator(
                          date: DefaultDateFormatter.format(ticket.entryAt),
                          time: TimeFormatter.format(ticket.entryAt),
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.vMedium,
                  InfoText(
                    infoName: 'Produtor',
                    infoValue:
                        ticket.field.grower.growerName?.toUpperCase() ??
                        AppStrings.unknownGrower.toUpperCase(),
                    secondInfoValue:
                        ticket.field.member.memberName ??
                        AppStrings.unknownMember,
                  ),
                  AppSpacing.vMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoText(
                        infoName: 'Talhão/Campo',
                        infoValue: ticket.field.number,
                        isLimited: true,
                      ),
                      InfoText(
                        infoName: 'Cultivar',
                        infoValue: ticket.field.cultivar.name,
                        isLimited: true,
                      ),
                      SizedBox(
                        width: 80,
                        child: InfoText(
                          infoName: 'Categoria',
                          infoValue: ticket.field.seedCategory,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Padding(
                    padding: AppInsets.hMedium,
                    child: Container(
                      height: 200,
                      width: 0.5,
                      color: outlineVariantColor,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: AppInsets.vExtraSmall,
                          decoration: BoxDecoration(
                            color: context.colors.primary,
                            borderRadius: AppBorderRadius.allLarge,
                          ),
                          child: Center(
                            child: Text(
                              ticket.hopperName ?? AppStrings.unknownHopper,
                              style: bodyLargeText.copyWith(
                                color: context.colors.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        AppSpacing.vLarge,
                        ProductionWeighingIndicators(
                          moisture: MoistureFormatter.format(
                            ticket.moisture ?? 0.0,
                          ),
                          grossWeight: WeightFormatter.format(
                            ticket.grossWeight,
                          ),
                          netWeight: WeightFormatter.format(ticket.netWeight),
                          showNetWeight: ticketStatus == '',
                        ),
                        AppSpacing.vExtraLarge,
                        Text(
                          ticketStatus,
                          style: bodyLargeText.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
