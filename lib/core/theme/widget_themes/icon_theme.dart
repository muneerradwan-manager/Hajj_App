import 'package:flutter/material.dart';

IconThemeData buildAppIconTheme(ColorScheme cs) {
  return IconThemeData(color: cs.onSurface, size: 24);
}

IconThemeData buildAppPrimaryIconTheme(ColorScheme cs) {
  return IconThemeData(color: cs.primary, size: 24);
}
