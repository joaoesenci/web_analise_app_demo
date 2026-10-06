import 'package:flutter/cupertino.dart';
import 'package:web_analise_app/shared/themes/helpers/app_spacing.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';
import 'package:web_analise_app/shared/themes/tokens/app_icon_sizes.dart';

class IconedInfoText extends StatelessWidget {
  final String icon;
  final Color iconColor;
  final double? customIconSize;
  final String infoName;
  final String infoValue;
  final String? secondInfoValue;

  const IconedInfoText({
    super.key,
    required this.icon,
    required this.iconColor,
    this.customIconSize,
    required this.infoName,
    required this.infoValue,
    this.secondInfoValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: customIconSize ?? AppIconSizes.small,
          width: customIconSize ?? AppIconSizes.small,
          child: Image.asset(icon, color: iconColor),
        ),
        AppSpacing.hSmall,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(infoName, style: context.texts.bodyMedium),
            Text(
              infoValue,
              maxLines: 1,
              style: context.texts.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (secondInfoValue != null)
              Text(
                secondInfoValue!,
                maxLines: 1,
                style: context.texts.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
