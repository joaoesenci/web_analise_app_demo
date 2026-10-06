import 'package:flutter/material.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';

class ProductionDatetimeIndicator extends StatelessWidget {
  final String date;
  final String time;

  const ProductionDatetimeIndicator({
    super.key,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = context.texts.bodyMedium!.copyWith(
      fontWeight: FontWeight.w300,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(date, style: textStyle),
        Text(time, style: textStyle),
      ],
    );
  }
}
