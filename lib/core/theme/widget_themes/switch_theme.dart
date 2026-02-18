import 'package:flutter/material.dart';

SwitchThemeData buildAppSwitchTheme(ColorScheme cs) {
  return SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return cs.onPrimary;
      }
      return cs.outline;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return cs.primary;
      }
      return cs.surfaceContainerHighest;
    }),
  );
}
