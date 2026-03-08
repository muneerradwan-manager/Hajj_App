import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

enum GradientColors { red, green, gold }

class GradientElevatedButton extends StatelessWidget {
  const GradientElevatedButton({
    super.key,
    this.textKey,
    this.child,
    required this.onPressed,
    this.isLoading = false,
    required this.gradientColor,
    this.padding,
  }) : assert(
         textKey != null || child != null,
         'Either textKey or child must be provided',
       );

  final String? textKey;
  final Widget? child;
  final VoidCallback? onPressed;
  final bool isLoading;
  final GradientColors gradientColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // تحويل enum إلى قائمة ألوان فعلية
    final List<Color> colors = gradientColor.resolve(cs);

    // إذا كان الزر معطل، نطبق شفافية
    final bool isDisabled = onPressed == null || isLoading;

    final List<Color> gradientColors = colors
        .map((c) => isDisabled ? c.withValues(alpha: 0.5) : c)
        .toList();

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: padding,
        ),
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
            : child ??
                  CustomText(
                    textKey!,
                    type: CustomTextType.titleMedium,
                    color: CustomTextColor.white,
                  ),
      ),
    );
  }
}

// Extension لتحويل enum إلى List<Color>
extension GradientColorsX on GradientColors {
  List<Color> resolve(ColorScheme cs) {
    switch (this) {
      case GradientColors.red:
        return [cs.brandRedAlt, cs.brandRed];
      case GradientColors.green:
        return [cs.primaryContainer, cs.primary];
      case GradientColors.gold:
        return [cs.surfaceDim, cs.brandGold];
    }
  }
}
