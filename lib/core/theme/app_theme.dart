// ============================================================
// App Theme
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/core/theme/widget_themes/widget_themes.dart';

class AppTheme {
  AppTheme._();

  static const String _fontFamily = 'Cairo';

  static ThemeData get lightTheme {
    return _buildTheme(
      colorScheme: AppColors.lightColorScheme,
      overlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  static ThemeData get darkTheme {
    return _buildTheme(
      colorScheme: AppColors.darkColorScheme,
      overlayStyle: SystemUiOverlayStyle.light,
    );
  }

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required SystemUiOverlayStyle overlayStyle,
  }) {
    final ColorScheme cs = colorScheme;

    return ThemeData(
      useMaterial3: true,
      brightness: cs.brightness,
      colorScheme: cs,
      scaffoldBackgroundColor: cs.surface,
      canvasColor: cs.surface,
      textTheme: buildAppTextTheme(cs).apply(
        fontFamily: _fontFamily,
        displayColor: cs.onSurface,
        bodyColor: cs.onSurface,
      ),
      fontFamily: _fontFamily,
      fontFamilyFallback: const [_fontFamily],
      appBarTheme: buildAppBarTheme(cs, overlayStyle),
      cardTheme: buildAppCardTheme(cs),
      elevatedButtonTheme: buildAppElevatedButtonTheme(cs),
      outlinedButtonTheme: buildAppOutlinedButtonTheme(cs),
      textButtonTheme: buildAppTextButtonTheme(cs),
      floatingActionButtonTheme: buildAppFloatingActionButtonTheme(cs),
      inputDecorationTheme: buildAppInputDecorationTheme(cs),
      bottomNavigationBarTheme: buildAppBottomNavigationBarTheme(cs),
      navigationBarTheme: buildAppNavigationBarTheme(cs),
      chipTheme: buildAppChipTheme(cs),
      dialogTheme: buildAppDialogTheme(cs),
      switchTheme: buildAppSwitchTheme(cs),
      checkboxTheme: buildAppCheckboxTheme(cs),
      radioTheme: buildAppRadioTheme(cs),
      snackBarTheme: buildAppSnackBarTheme(cs),
      bottomSheetTheme: buildAppBottomSheetTheme(cs),
      drawerTheme: buildAppDrawerTheme(cs),
      dividerTheme: buildAppDividerTheme(cs),
      listTileTheme: buildAppListTileTheme(),
      iconTheme: buildAppIconTheme(cs),
      primaryIconTheme: buildAppPrimaryIconTheme(cs),
    );
  }
}
