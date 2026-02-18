import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

NavigationBarThemeData buildAppNavigationBarTheme(ColorScheme cs) {
  return NavigationBarThemeData(
    elevation: AppSizes.elevationSm,
    backgroundColor: cs.surface,
    indicatorColor: cs.primaryContainer,
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: cs.onSurface,
        );
      }

      return TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: cs.outline,
      );
    }),
  );
}
