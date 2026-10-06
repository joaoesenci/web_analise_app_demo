import 'package:flutter/material.dart';
import 'package:web_analise_app/shared/themes/theme_extension.dart';

class ProductionLoadingSection extends StatelessWidget {
  const ProductionLoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: context.colors.primary),
    );
  }
}
