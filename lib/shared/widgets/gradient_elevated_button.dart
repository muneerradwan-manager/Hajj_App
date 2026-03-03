import 'package:flutter/material.dart';

import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

/// Elevated button with a vertical primary gradient background.
class GradientElevatedButton extends StatelessWidget {
  const GradientElevatedButton({
    super.key,
    required this.textKey,
    required this.onPressed,
    this.isLoading = false,
  });

  final String textKey;
  final VoidCallback? onPressed;
  final bool isLoading;

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
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : CustomText(
                textKey,
                type: CustomTextType.titleMedium,
                color: CustomTextColor.white,
              ),
      ),
    );
  }
}
