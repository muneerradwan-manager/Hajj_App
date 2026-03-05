import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

enum CustomBorderSide {
  borderLeft,
  borderTop,
  borderRight,
  borderBottom,
  allBorder,
  horizontalBorder,
  verticalBorder,
}

enum CustomBorderColor {
  green,
  lightGreen,
  gold,
  lightGold,
  red,
  lightRed,
  hint,
  white,
  black,
  transparent,
}

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final CustomBorderSide borderSide;
  final CustomBorderColor borderColor;
  final double borderWidth;
  final Color? containerColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool hasShadow;
  final double? hasOpacity;
  final double? width;
  final double? height;
  final double? borderHasOpacity;

  /// **NEW**: optional gradient
  final List<Color>? gradientColors;
  final Alignment gradientBegin;
  final Alignment gradientEnd;

  const CustomContainer({
    super.key,
    this.child,
    this.borderSide = CustomBorderSide.allBorder,
    this.borderColor = CustomBorderColor.transparent,
    this.borderWidth = 8,
    this.containerColor = Colors.white,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.all(20),
    this.hasShadow = true,
    this.hasOpacity,
    this.width,
    this.height,
    this.gradientColors,
    this.gradientBegin = Alignment.topCenter,
    this.gradientEnd = Alignment.bottomCenter,
    this.borderHasOpacity,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      clipBehavior: Clip.antiAlias,
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderSide.resolve(
          borderColor.resolve(cs).withValues(alpha: borderHasOpacity),
          borderWidth,
        ),
        color: gradientColors == null
            ? containerColor?.withValues(alpha: hasOpacity)
            : null,
        gradient: gradientColors != null
            ? LinearGradient(
                begin: gradientBegin,
                end: gradientEnd,
                colors: gradientColors!,
              )
            : null,
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}

extension CustomBorderSideX on CustomBorderSide {
  Border resolve(Color color, double width) {
    switch (this) {
      case CustomBorderSide.borderLeft:
        return Border(
          left: BorderSide(color: color, width: width),
        );
      case CustomBorderSide.borderTop:
        return Border(
          top: BorderSide(color: color, width: width),
        );
      case CustomBorderSide.borderRight:
        return Border(
          right: BorderSide(color: color, width: width),
        );
      case CustomBorderSide.borderBottom:
        return Border(
          bottom: BorderSide(color: color, width: width),
        );
      case CustomBorderSide.allBorder:
        return Border.all(color: color, width: width);
      case CustomBorderSide.verticalBorder:
        return Border(
          left: BorderSide(color: color, width: width),
          right: BorderSide(color: color, width: width),
        );
      case CustomBorderSide.horizontalBorder:
        return Border(
          top: BorderSide(color: color, width: width),
          bottom: BorderSide(color: color, width: width),
        );
    }
  }
}

extension CustomBorderColorX on CustomBorderColor {
  Color resolve(ColorScheme cs) {
    switch (this) {
      case CustomBorderColor.green:
        return cs.primary;
      case CustomBorderColor.lightGreen:
        return cs.primaryContainer;
      case CustomBorderColor.gold:
        return cs.brandGold;
      case CustomBorderColor.red:
        return cs.tertiary;
      case CustomBorderColor.lightRed:
        return cs.errorContainer;
      case CustomBorderColor.lightGold:
        return cs.surfaceDim;
      case CustomBorderColor.hint:
        return const Color(0xff62748E);
      case CustomBorderColor.white:
        return AppColors.white;
      case CustomBorderColor.black:
        return AppColors.black;
      case CustomBorderColor.transparent:
        return Colors.transparent;
    }
  }
}
