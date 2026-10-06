import 'package:flutter/material.dart';
import 'package:web_analise_app/features/production/presentation/components/widgets/production_page/production_navigation_bar/production_navigation_bar.dart';
import 'package:web_analise_app/shared/themes/helpers/app_border_radius.dart';
import 'package:web_analise_app/shared/themes/tokens/app_widgets_sizes.dart';

class ProductionAppbar extends StatelessWidget implements PreferredSizeWidget {
  final int currentStepIndex;
  final ValueChanged<int> onChangePage;

  const ProductionAppbar({
    super.key,
    required this.currentStepIndex,
    required this.onChangePage,
  });

  static const double bottomHeight = 140;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Entrada de Produção'),
      shape: const RoundedRectangleBorder(
        borderRadius: AppBorderRadius.bottomExtraLarge,
      ),
      bottom: ProductionNavigationBar(
        currentStepIndex: currentStepIndex,
        totalHeight: bottomHeight,
        onChangeStep: (stepIndex) => onChangePage(stepIndex),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(AppWidgetSizes.appBarHeight + bottomHeight);
}
