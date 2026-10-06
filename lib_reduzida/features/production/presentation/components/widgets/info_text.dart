import 'package:flutter/material.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';

class InfoText extends StatelessWidget {
  final String infoName;
  final String infoValue;
  final String? secondInfoValue;
  final bool isLimited;

  const InfoText({
    super.key,
    required this.infoName,
    required this.infoValue,
    this.secondInfoValue,
    this.isLimited = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isLimited ? 140 : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
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
    );
  }
}
