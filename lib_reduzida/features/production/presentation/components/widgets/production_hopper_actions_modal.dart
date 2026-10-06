import 'package:flutter/material.dart';
import 'package:web_analise_app/features/production/domain/entities/hopper_entity.dart';
import 'package:web_analise_app/shared/constants/app_icons.dart';
import 'package:web_analise_app/shared/constants/app_strings.dart';
import 'package:web_analise_app/shared/widgets/buttons/feature_actions_modal_button.dart';
import 'package:web_analise_app/shared/widgets/modals/feature_item_actions_modal.dart';

class ProductionHopperActionsModal extends StatelessWidget {
  final HopperEntity hopper;
  final String statusName;
  final Color primaryColor;
  final Color statusColor;
  final VoidCallback onCancel;
  final VoidCallback onTapEmptyHopper;
  final VoidCallback onTapCleaningHopper;

  const ProductionHopperActionsModal({
    super.key,
    required this.hopper,
    required this.statusName,
    required this.primaryColor,
    required this.statusColor,
    required this.onCancel,
    required this.onTapEmptyHopper,
    required this.onTapCleaningHopper,
  });

  static Future<void> show({
    required BuildContext context,
    required HopperEntity hopper,
    required String statusName,
    required Color primaryColor,
    required Color statusColor,
    required VoidCallback onCancel,
    required VoidCallback onTapEmptyHopper,
    required VoidCallback onTapCleaningHopper,
  }) {
    return showModalBottomSheet(
      constraints: const BoxConstraints(),
      context: context,
      isScrollControlled: true,
      builder: (context) => ProductionHopperActionsModal(
        hopper: hopper,
        statusName: statusName,
        primaryColor: primaryColor,
        statusColor: statusColor,
        onCancel: onCancel,
        onTapEmptyHopper: onTapEmptyHopper,
        onTapCleaningHopper: onTapCleaningHopper,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final actions = [
      if (hopper.status == AppStrings.hopperInUse)
        FeatureActionsModalButton(
          title: 'Esvaziar Moega',
          description: 'Esvazie a moega para o recebimento de um novo produto',
          color: primaryColor,
          icon: AppIcons.cleaning,
          onTap: onTapEmptyHopper,
        ),
      if (hopper.status == AppStrings.hopperEmpty)
        FeatureActionsModalButton(
          title: 'Checklist de Limpeza',
          description:
              'Para liberar a moega para recebimento, realiza a limpeza.',
          color: primaryColor,
          icon: AppIcons.countList,
          onTap: onTapCleaningHopper,
        ),
    ];

    return FeatureItemActionsModal(
      itemName: hopper.hopperName.toUpperCase(),
      iconPath: AppIcons.hopper2,
      iconBackgroundColor: primaryColor,
      status: statusName,
      statusColor: statusColor,
      modalActionsButtons: actions,
      onCancel: onCancel,
    );
  }
}
