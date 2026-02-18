import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

DividerThemeData buildAppDividerTheme(ColorScheme cs) {
  return DividerThemeData(
    color: cs.outlineVariant,
    thickness: 1,
    space: AppSizes.spacingMd,
  );
}
