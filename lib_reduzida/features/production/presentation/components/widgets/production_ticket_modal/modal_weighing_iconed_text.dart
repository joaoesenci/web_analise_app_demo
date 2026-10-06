import 'package:flutter/cupertino.dart';
import 'package:web_analise_app/shared/constants/app_icons.dart';
import 'package:web_analise_app/shared/themes/helpers/app_spacing.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';
import 'package:web_analise_app/shared/themes/tokens/app_sizes.dart';

class ModalWeighingIconedText extends StatelessWidget {
  final String title;
  final String value;
  final bool format;

  const ModalWeighingIconedText({
    super.key,
    required this.title,
    required this.value,
    this.format = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.extraLarge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
                width: 18,
                child: Image.asset(AppIcons.scale),
              ),
              AppSpacing.hExtraSmall,
              Text(title, style: context.texts.titleLarge),
            ],
          ),
          SizedBox(
            width: 170,
            child: Text(
              format
                  ? value.isEmpty
                        ? ''
                        : '$value kg'
                  : value,
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.texts.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
