import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/core/localization/app_localizations_setup.dart';

enum CustomTextType {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

enum CustomTextColor {
  // ColorScheme.primary
  green,
  // ColorScheme.primaryContainer
  lightGreen,
  // App brand gold token.
  gold,
  // ColorScheme.surfaceDim
  lightGold,
  // ColorScheme.tertiary
  red,
  // ColorScheme.errorContainer
  lightRed,
  // ColorScheme.outline
  hint,
  white,
  black,
}

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    super.key,
    this.type = CustomTextType.bodyMedium,
    this.color,
    this.translate = true,
    this.args,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.style,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.letterSpacing,
  });

  final String text;
  final CustomTextType type;
  final CustomTextColor? color;
  final bool translate;
  final Map<String, dynamic>? args;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextStyle? style;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? height;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseStyle = type.resolve(theme.textTheme);
    final resolvedColor = color?.resolve(theme.colorScheme);

    final resolvedStyle = baseStyle
        ?.copyWith(
          color: resolvedColor ?? baseStyle.color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          height: height,
          letterSpacing: letterSpacing,
        )
        .merge(style);

    return Text(
      translate ? text.tr(context, args: args) : text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: resolvedStyle ?? style,
    );
  }
}

extension CustomTextTypeX on CustomTextType {
  TextStyle? resolve(TextTheme textTheme) {
    switch (this) {
      case CustomTextType.displayLarge:
        return textTheme.displayLarge;
      case CustomTextType.displayMedium:
        return textTheme.displayMedium;
      case CustomTextType.displaySmall:
        return textTheme.displaySmall;
      case CustomTextType.headlineLarge:
        return textTheme.headlineLarge;
      case CustomTextType.headlineMedium:
        return textTheme.headlineMedium;
      case CustomTextType.headlineSmall:
        return textTheme.headlineSmall;
      case CustomTextType.titleLarge:
        return textTheme.titleLarge;
      case CustomTextType.titleMedium:
        return textTheme.titleMedium;
      case CustomTextType.titleSmall:
        return textTheme.titleSmall;
      case CustomTextType.bodyLarge:
        return textTheme.bodyLarge;
      case CustomTextType.bodyMedium:
        return textTheme.bodyMedium;
      case CustomTextType.bodySmall:
        return textTheme.bodySmall;
      case CustomTextType.labelLarge:
        return textTheme.labelLarge;
      case CustomTextType.labelMedium:
        return textTheme.labelMedium;
      case CustomTextType.labelSmall:
        return textTheme.labelSmall;
    }
  }
}

extension CustomTextColorX on CustomTextColor {
  Color resolve(ColorScheme cs) {
    switch (this) {
      case CustomTextColor.green:
        return cs.primary;
      case CustomTextColor.lightGreen:
        return cs.primaryContainer;
      case CustomTextColor.gold:
        return cs.brandGold;
      case CustomTextColor.red:
        return cs.tertiary;
      case CustomTextColor.lightRed:
        return cs.errorContainer;
      case CustomTextColor.lightGold:
        return cs.surfaceDim;
      case CustomTextColor.hint:
        return cs.outline;
      case CustomTextColor.white:
        return AppColors.white;
      case CustomTextColor.black:
        return AppColors.black;
    }
  }
}
