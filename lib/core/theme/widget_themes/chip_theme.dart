import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

ChipThemeData buildAppChipTheme(ColorScheme cs) {
  return ChipThemeData(
    backgroundColor: cs.surfaceContainer,
    selectedColor: cs.secondaryContainer,
    disabledColor: cs.surfaceContainerHighest,
    labelStyle: TextStyle(color: cs.onSurface),
    secondaryLabelStyle: TextStyle(color: cs.onSecondaryContainer),
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.spacingMd,
      vertical: AppSizes.spacingSm,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
    ),
  );
}
