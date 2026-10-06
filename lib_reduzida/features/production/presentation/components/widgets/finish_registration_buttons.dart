import 'package:flutter/material.dart';
import 'package:web_analise_app/shared/themes/helpers/app_spacing.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';
import 'package:web_analise_app/shared/themes/tokens/app_icon_sizes.dart';
import 'package:web_analise_app/shared/widgets/buttons/app_filled_button.dart';
import 'package:web_analise_app/shared/widgets/buttons/app_outlined_button.dart';

class FinishRegistrationButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final bool isEditable;

  const FinishRegistrationButtons({
    super.key,
    required this.onCancel,
    required this.onSave,
    required this.isEditable,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.colors.primary;
    final onPrimaryColor = context.colors.onPrimary;

    return Row(
      children: [
        Expanded(
          child: AppOutlinedButton(
            onPressed: onCancel,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.close,
                  size: AppIconSizes.small,
                  fontWeight: FontWeight.bold,
                ),
                AppSpacing.hExtraSmall,
                Text(
                  'Cancelar',
                  style: context.texts.bodyLarge!.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isEditable) ...[
          AppSpacing.hLarge,
          Expanded(
            child: AppFilledButton(
              onPressed: onSave,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.save_outlined,
                    size: AppIconSizes.small,
                    color: onPrimaryColor,
                  ),
                  AppSpacing.hSmall,
                  Text(
                    'Gravar',
                    style: context.texts.bodyLarge!.copyWith(
                      color: onPrimaryColor,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
