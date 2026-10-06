import 'package:flutter/cupertino.dart';
import 'package:web_analise_app/features/production/presentation/components/widgets/production_page/production_navigation_bar/production_navigation_bar_item.dart';
import 'package:web_analise_app/shared/constants/app_icons.dart';
import 'package:web_analise_app/shared/themes/tokens/app_sizes.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';

class ProductionNavigationBar extends StatelessWidget
    implements PreferredSizeWidget {
  final double totalHeight;
  final int currentStepIndex;
  final ValueChanged<int> onChangeStep;

  const ProductionNavigationBar({
    super.key,
    required this.currentStepIndex,
    required this.totalHeight,
    required this.onChangeStep,
  });

  static const double _greenPadding = 60;
  static const double _bottomCurve = AppSizes.medium;

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.colors.primary;
    final surfaceColor = context.colors.surface;

    return SizedBox(
      height: totalHeight - _greenPadding,
      width: context.screenWidth * 0.85,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double halfWidth = constraints.maxWidth / 2;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProductionNavigationBarItem(
                    isSelected: currentStepIndex == 0,
                    text: 'Entrada de Produção',
                    icon: AppIcons.leaf,
                    onChangePage: () => onChangeStep(0),
                  ),
                  ProductionNavigationBarItem(
                    isSelected: currentStepIndex == 1,
                    text: 'Moegas',
                    icon: AppIcons.hopper,
                    onChangePage: () => onChangeStep(1),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: currentStepIndex == 0
                    ? -_bottomCurve
                    : halfWidth - _bottomCurve,
                child: Container(
                  height: _bottomCurve,
                  width: _bottomCurve,
                  decoration: BoxDecoration(color: surfaceColor),
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(_bottomCurve),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: currentStepIndex == 0 ? halfWidth : constraints.maxWidth,
                child: Container(
                  height: _bottomCurve,
                  width: _bottomCurve,
                  decoration: BoxDecoration(color: surfaceColor),
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(_bottomCurve),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(totalHeight);
}
