import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

enum GradientColors { red, green, gold, outline }

class GradientElevatedButton extends StatelessWidget {
  const GradientElevatedButton({
    super.key,
    this.textKey,
    this.child,
    this.icon,
    this.iconGap = 8,
    required this.onPressed,
    this.isLoading = false,
    required this.gradientColor,
    this.padding,
    this.borderRadius = 10,
  }) : assert(
         textKey != null || child != null,
         'Either textKey or child must be provided',
       );

  final String? textKey;
  final Widget? child;
  final Widget? icon;
  final double iconGap;
  final VoidCallback? onPressed;
  final bool isLoading;
  final GradientColors gradientColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final List<Color> colors = gradientColor.resolve(cs);

    final bool isDisabled = onPressed == null || isLoading;

    final List<Color> gradientColors = colors
        .map((c) => isDisabled ? c.withValues(alpha: 0.5) : c)
        .toList();

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
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
            : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    final Widget label =
        child ??
        CustomText(
          textKey!,
          type: CustomTextType.titleMedium,
          color: CustomTextColor.white,
        );

    if (icon == null) return label;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon!,
        SizedBox(width: iconGap),
        label,
      ],
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
      case GradientColors.outline:
        return [cs.outlineVariant, cs.outline];
    }
  }
}
