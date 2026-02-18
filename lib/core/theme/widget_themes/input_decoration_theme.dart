import 'package:flutter/material.dart';

InputDecorationTheme buildAppInputDecorationTheme(ColorScheme cs) {
  final border = OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: cs.outline, width: 1.2),
  );
  return InputDecorationTheme(
    hintStyle: TextStyle(color: cs.outline, fontWeight: FontWeight.w500),
    isDense: true,
    filled: true,
    fillColor: cs.surface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
    border: border,
    enabledBorder: border,
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: cs.primary, width: 1.4),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: cs.error, width: 1.2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: cs.error, width: 1.4),
    ),

    suffixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 42),
  );
}
