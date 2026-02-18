import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

CheckboxThemeData buildAppCheckboxTheme(ColorScheme cs) {
  return CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return cs.primary;
      }
      return cs.surfaceContainerHighest;
    }),
    checkColor: WidgetStateProperty.all(cs.onPrimary),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
    ),
  );
}
