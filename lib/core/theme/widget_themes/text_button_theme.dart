import 'package:flutter/material.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

TextButtonThemeData buildAppTextButtonTheme(ColorScheme cs) {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      ),
      foregroundColor: cs.secondary,
      minimumSize: const Size(0, 0),
      padding: const EdgeInsets.all(5),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  );
}
