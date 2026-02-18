import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hajj_app/core/constants/app_sizes.dart';

AppBarTheme buildAppBarTheme(
  ColorScheme cs,
  SystemUiOverlayStyle overlayStyle,
) {
  return AppBarTheme(
    elevation: AppSizes.elevationSm,
    centerTitle: false,
    backgroundColor: cs.surface,
    foregroundColor: cs.onSurface,
    surfaceTintColor: cs.surfaceTint,
    systemOverlayStyle: overlayStyle,
    titleTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: cs.onSurface,
    ),
  );
}
