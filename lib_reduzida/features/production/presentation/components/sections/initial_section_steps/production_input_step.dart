import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:web_analise_app/features/production/domain/entities/production_ticket_entity.dart';
import 'package:web_analise_app/features/production/presentation/components/widgets/production_page/production_listview/production_listview_item.dart';
import 'package:web_analise_app/features/production/presentation/components/widgets/production_page/production_ticket_modal/production_ticket_actions_modal.dart';
import 'package:web_analise_app/shared/constants/app_strings.dart';
import 'package:web_analise_app/shared/themes/helpers/app_insets.dart';
import 'package:web_analise_app/shared/themes/helpers/app_spacing.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';
import 'package:web_analise_app/shared/themes/tokens/app_fading_values.dart';

class ProductionInputStep extends StatelessWidget {
  final List<ProductionTicketEntity> tickets;
  final ScrollController ticketsScrollController;
  final TextEditingController grossWeightController;
  final TextEditingController tareWeightController;
  final TextEditingController impurityWeightController;
  final TextEditingController moistureController;
  final VoidCallback onCancelModal;
  final VoidCallback whenCompleteModal;
  final ValueChanged<int> onSaveWeighing;
  final ValueChanged<int> onTapShowDetails;
  final ValueChanged<int> onTapStartUnloading;
  final ValueChanged<int> onTapFinishUnloading;

  const ProductionInputStep({
    super.key,
    required this.tickets,
    required this.ticketsScrollController,
    required this.grossWeightController,
    required this.tareWeightController,
    required this.impurityWeightController,
    required this.moistureController,
    required this.onCancelModal,
    required this.onSaveWeighing,
    required this.whenCompleteModal,
    required this.onTapShowDetails,
    required this.onTapStartUnloading,
    required this.onTapFinishUnloading,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.colors.primary;

    return FadingEdgeScrollView.fromScrollView(
      gradientFractionOnStart: AppFadingValues.mediumScrollFading,
      gradientFractionOnEnd: AppFadingValues.mediumScrollFading,
      child: ListView.separated(
        itemCount: tickets.length,
        controller: ticketsScrollController,
        padding: AppInsets.featureListViewSafeArea,
        separatorBuilder: (context, index) => AppSpacing.vLarge,
        itemBuilder: (context, index) {
          final ticket = tickets[index];

          final ticketStatusName = switch (ticket.status) {
            AppStrings.productionTicketCompleted => 'ENCERRADO',
            AppStrings.productionTicketAwaiting => 'AGUARDANDO',
            AppStrings.productionTicketInProgress => 'DESCARREGANDO',
            _ => AppStrings.unknownStatus,
          };

          final ticketStatusColor = switch (ticket.status) {
            AppStrings.productionTicketCompleted => primaryColor,
            AppStrings.productionTicketAwaiting => const Color(0xFFE17E02),
            AppStrings.productionTicketInProgress => primaryColor,
            _ => context.colors.outline,
          };

          return ProductionListviewItem(
            ticket: ticket,
            onTap: () => ProductionTicketActionsModal.show(
              context: context,
              ticket: ticket,
              statusName: ticketStatusName,
              primaryColor: primaryColor,
              statusColor: ticketStatusColor,
              grossWeightController: grossWeightController,
              tareWeightController: tareWeightController,
              impurityWeightController: impurityWeightController,
              moistureController: moistureController,
              onCancel: onCancelModal,
              onSaveWeighing: () => onSaveWeighing(ticket.id),
              onTapShowDetails: () => onTapShowDetails(ticket.id),
              onTapStartUnloading: () => onTapStartUnloading(ticket.id),
              onTapFinishUnloading: () => onTapFinishUnloading(ticket.id),
            ).whenComplete(whenCompleteModal),
          );
        },
      ),
    );
  }
}
