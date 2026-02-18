import 'package:flutter/material.dart';

RadioThemeData buildAppRadioTheme(ColorScheme cs) {
  return RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return cs.primary;
      }
      return cs.outline;
    }),
  );
}
