import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

BottomNavigationBarThemeData buildAppBottomNavigationBarTheme(ColorScheme cs) {
  return BottomNavigationBarThemeData(
    elevation: AppSizes.elevationMd,
    backgroundColor: cs.surface,
    selectedItemColor: cs.primary,
    unselectedItemColor: cs.outline,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  );
}
