import 'package:flutter/material.dart';
import 'package:web_analise_app/features/production/domain/entities/production_ticket_entity.dart';
import 'package:web_analise_app/features/production/presentation/components/widgets/production_page/production_ticket_modal/modal_weighing_box.dart';
import 'package:web_analise_app/features/production/presentation/components/widgets/production_page/production_ticket_modal/outlined_icon_info_text.dart';
import 'package:web_analise_app/shared/constants/app_icons.dart';
import 'package:web_analise_app/shared/constants/app_strings.dart';
import 'package:web_analise_app/shared/themes/helpers/app_spacing.dart';
import 'package:web_analise_app/shared/widgets/buttons/feature_actions_modal_button.dart';
import 'package:web_analise_app/shared/widgets/modals/feature_item_actions_modal.dart';

class ProductionTicketActionsModal extends StatefulWidget {
  final ProductionTicketEntity ticket;
  final String statusName;
  final Color primaryColor;
  final Color statusColor;
  final TextEditingController grossWeightController;
  final TextEditingController tareWeightController;
  final TextEditingController impurityWeightController;
  final TextEditingController moistureController;
  final VoidCallback onCancel;
  final VoidCallback onSaveWeighing;
  final VoidCallback onTapShowDetails;
  final VoidCallback onTapStartUnloading;
  final VoidCallback onTapFinishUnloading;

  const ProductionTicketActionsModal({
    super.key,
    required this.ticket,
    required this.statusName,
    required this.primaryColor,
    required this.statusColor,
    required this.grossWeightController,
    required this.tareWeightController,
    required this.impurityWeightController,
    required this.moistureController,
    required this.onCancel,
    required this.onSaveWeighing,
    required this.onTapShowDetails,
    required this.onTapStartUnloading,
    required this.onTapFinishUnloading,
  });

  static Future<void> show({
    required BuildContext context,
    required ProductionTicketEntity ticket,
    required String statusName,
    required Color primaryColor,
    required Color statusColor,
    required TextEditingController grossWeightController,
    required TextEditingController tareWeightController,
    required TextEditingController impurityWeightController,
    required TextEditingController moistureController,
    required VoidCallback onCancel,
    required VoidCallback onSaveWeighing,
    required VoidCallback onTapShowDetails,
    required VoidCallback onTapStartUnloading,
    required VoidCallback onTapFinishUnloading,
  }) {
    return showModalBottomSheet<void>(
      constraints: const BoxConstraints(),
      context: context,
      isScrollControlled: true,
      builder: (context) => ProductionTicketActionsModal(
        ticket: ticket,
        statusName: statusName,
        primaryColor: primaryColor,
        statusColor: statusColor,
        grossWeightController: grossWeightController,
        tareWeightController: tareWeightController,
        impurityWeightController: impurityWeightController,
        moistureController: moistureController,
        onCancel: onCancel,
        onSaveWeighing: onSaveWeighing,
        onTapShowDetails: onTapShowDetails,
        onTapStartUnloading: onTapStartUnloading,
        onTapFinishUnloading: onTapFinishUnloading,
      ),
    );
  }

  @override
  State<ProductionTicketActionsModal> createState() =>
      _ProductionTicketActionsModalState();
}

class _ProductionTicketActionsModalState
    extends State<ProductionTicketActionsModal> {
  bool _isWeighingMode = false;

  @override
  Widget build(BuildContext context) {
    final status = widget.ticket.status;
    final primaryColor = widget.primaryColor;

    final body = Row(
      children: [
        OutlinedIconInfoText(
          infoName: 'Ticket',
          infoValue: widget.ticket.number.toString(),
          icon: AppIcons.thinTicket,
        ),
        AppSpacing.hLarge,
        OutlinedIconInfoText(
          infoName: 'Placa',
          infoValue: widget.ticket.plate,
          icon: AppIcons.thinCar,
        ),
      ],
    );

    final defaultActions = [
      FeatureActionsModalButton(
        title: 'Ver Detalhes',
        description: 'Visualize todas as informações da entrada.',
        color: primaryColor,
        icon: AppIcons.outlinedPapers,
        onTap: widget.onTapShowDetails,
      ),
      FeatureActionsModalButton(
        title: 'Registrar pesagem/umidade',
        description: 'Informe o peso bruto, peso líquido e umidade da entrada.',
        color: const Color(0xFF2D77C7),
        icon: AppIcons.outlinedMoistureScale,
        onTap: () => setState(() => _isWeighingMode = true),
      ),
      if (status == AppStrings.productionTicketAwaiting)
        FeatureActionsModalButton(
          title: 'Iniciar o descarregamento',
          description: 'Inicie o processo de descarregamento do caminhão.',
          color: const Color(0xFFE17E02),
          icon: AppIcons.outlinedTruck,
          onTap: widget.onTapStartUnloading,
        ),
      if (status == AppStrings.productionTicketInProgress)
        FeatureActionsModalButton(
          title: 'Finalizar o descarregamento',
          description: 'Finalize o processo de descarregamento do caminhão.',
          color: const Color(0xFF7856A4),
          icon: AppIcons.outlinedTruck,
          onTap: widget.onTapFinishUnloading,
        ),
    ];

    final locationActions = [
      ModalWeighingBox(
        grossWeightController: widget.grossWeightController,
        tareWeightController: widget.tareWeightController,
        impurityWeightController: widget.impurityWeightController,
        moistureController: widget.moistureController,
        onCancel: widget.onCancel,
        onSave: widget.onSaveWeighing,
      ),
    ];

    return FeatureItemActionsModal(
      itemName: widget.ticket.hopperName ?? AppStrings.unknownHopper,
      iconPath: AppIcons.hopper2,
      iconBackgroundColor: primaryColor,
      status: widget.statusName,
      statusColor: widget.statusColor,
      body: body,
      actionsTitle: _isWeighingMode
          ? 'Dados da Pesagem/Umidade'
          : 'Ações Disponíveis',
      modalActionsButtons: _isWeighingMode ? locationActions : defaultActions,
      personCancelButtonText: _isWeighingMode ? 'Voltar' : null,
      personCancelButtonIcon: _isWeighingMode ? Icons.arrow_back_rounded : null,
      saveButton: true,
      onSave: widget.onSaveWeighing,
      onCancel: _isWeighingMode
          ? () {
              setState(() => _isWeighingMode = false);
              widget.grossWeightController.clear();
              widget.tareWeightController.clear();
              widget.impurityWeightController.clear();
              widget.moistureController.clear();
            }
          : widget.onCancel,
    );
  }
}
