import 'package:flutter/material.dart';

import 'package:hajj_app/shared/widgets/custom_text.dart';

/// Elevated button with a vertical primary gradient background.
class GradientElevatedButton extends StatelessWidget {
  const GradientElevatedButton({
    super.key,
    required this.textKey,
    required this.onPressed,
  });

  final String textKey;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [cs.primaryContainer, cs.primary],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: CustomText(
          textKey,
          type: CustomTextType.titleMedium,
          color: CustomTextColor.white,
        ),
      ),
    );
  }
}
