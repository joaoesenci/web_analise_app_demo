import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_analise_app/features/production/domain/entities/hopper_entity.dart';
import 'package:web_analise_app/features/production/presentation/components/widgets/production_page/production_hopper_card.dart';
import 'package:web_analise_app/shared/themes/helpers/app_border_radius.dart';
import 'package:web_analise_app/shared/themes/helpers/app_insets.dart';
import 'package:web_analise_app/shared/themes/helpers/app_spacing.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';
import 'package:web_analise_app/shared/themes/tokens/app_fading_values.dart';
import 'package:web_analise_app/shared/themes/tokens/app_sizes.dart';

class HopperStep extends StatelessWidget {
  final List<HopperEntity> hoppers;
  final ScrollController scrollController;
  final VoidCallback onCancelModal;
  final ValueChanged<int> onTapEmptyHopper;
  final ValueChanged<int> onTapCleaningHopper;

  const HopperStep({
    super.key,
    required this.hoppers,
    required this.scrollController,
    required this.onCancelModal,
    required this.onTapEmptyHopper,
    required this.onTapCleaningHopper,
  });

  @override
  Widget build(BuildContext context) {
    final int disponibleHoppers = hoppers
        .where((i) => i.status == 'is_empty')
        .length;

    return Column(
      children: [
        AppSpacing.vExtraLarge,
        Padding(
          padding: AppInsets.hExtraLarge,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Visão Geral das Moegas',
                style: context.texts.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 50,
                width: 240,
                decoration: BoxDecoration(
                  color: const Color(0xFF14AE5C).withValues(alpha: 0.10),
                  border: Border.all(color: Color(0xFF14AE5C), width: 1),
                  borderRadius: AppBorderRadius.allExtraLarge,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${hoppers.length - disponibleHoppers} ocupadas',
                      style: context.texts.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    AppSpacing.hSmall,
                    Container(
                      height: 20,
                      width: 1,
                      color: context.colors.outline,
                    ),
                    AppSpacing.hSmall,
                    Text(
                      '$disponibleHoppers livres',
                      style: context.texts.bodyLarge!.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FadingEdgeScrollView.fromScrollView(
            gradientFractionOnEnd: AppFadingValues.mediumScrollFading,
            gradientFractionOnStart: AppFadingValues.mediumScrollFading,
            child: GridView.builder(
              itemCount: hoppers.length,
              controller: scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.large,
                vertical: AppSizes.extraLarge,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 340,
                mainAxisSpacing: AppSizes.large,
                crossAxisSpacing: AppSizes.large,
              ),
              itemBuilder: (context, index) {
                final hopper = hoppers.elementAt(index);

                return ProductionHopperCard(
                  hopper: hopper,
                  onCancel: onCancelModal,
                  onTapEmptyHopper: () => onTapEmptyHopper(hopper.id),
                  onTapCleaningHopper: () => onTapCleaningHopper(hopper.id),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
