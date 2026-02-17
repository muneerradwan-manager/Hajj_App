// ============================================================
// App Theme
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/core/constants/app_sizes.dart';

class AppTheme {
  AppTheme._();

  static const String _fontFamily = 'Cairo';

  static TextTheme _textTheme(ColorScheme cs) {
    final base = GoogleFonts.getTextTheme(_fontFamily);

    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        color: cs.onSurface,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: base.displayMedium?.copyWith(
        color: cs.onSurface,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: base.displaySmall?.copyWith(
        color: cs.onSurface,
        fontWeight: FontWeight.w700,
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        color: cs.onSurface,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        color: cs.onSurface,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        color: cs.onSurface,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: base.titleLarge?.copyWith(
        color: cs.onSurface,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: base.titleMedium?.copyWith(
        color: cs.onSurface,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: base.titleSmall?.copyWith(
        color: cs.onSurface,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        color: cs.onSurface,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        color: cs.onSurface,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: base.bodySmall?.copyWith(
        color: cs.onSurface.withValues(alpha: 0.8),
        fontWeight: FontWeight.w400,
      ),
      labelLarge: base.labelLarge?.copyWith(
        color: cs.onSurface,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: base.labelMedium?.copyWith(
        color: cs.onSurface.withValues(alpha: 0.9),
        fontWeight: FontWeight.w600,
      ),
      labelSmall: base.labelSmall?.copyWith(
        color: cs.onSurface.withValues(alpha: 0.8),
        fontWeight: FontWeight.w600,
      ),
    );
  }

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
    final cs = colorScheme;

    return ThemeData(
      useMaterial3: true,
      brightness: cs.brightness,
      colorScheme: cs,
      scaffoldBackgroundColor: cs.surface,
      canvasColor: cs.surface,
      textTheme: _textTheme(cs),

      appBarTheme: AppBarTheme(
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
      ),

      cardTheme: CardThemeData(
        elevation: AppSizes.elevationSm,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        ),
        color: cs.surface,
        surfaceTintColor: cs.surfaceTint,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: AppSizes.elevationSm,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacingLg,
            vertical: AppSizes.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          ),
          minimumSize: const Size(64, 48),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacingLg,
            vertical: AppSizes.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          ),
          side: BorderSide(color: cs.outline),
          minimumSize: const Size(64, 48),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacingLg,
            vertical: AppSizes.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          ),
          minimumSize: const Size(64, 48),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: AppSizes.elevationMd,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusXl),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cs.surfaceContainer,
        hintStyle: TextStyle(color: cs.outline),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacingMd,
          vertical: AppSizes.spacingMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          borderSide: BorderSide(color: cs.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          borderSide: BorderSide(color: cs.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          borderSide: BorderSide(color: cs.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          borderSide: BorderSide(color: cs.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          borderSide: BorderSide(color: cs.error, width: 2),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: AppSizes.elevationMd,
        backgroundColor: cs.surface,
        selectedItemColor: cs.primary,
        unselectedItemColor: cs.outline,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      navigationBarTheme: NavigationBarThemeData(
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
      ),

      chipTheme: ChipThemeData(
        backgroundColor: cs.surfaceContainer,
        selectedColor: cs.secondaryContainer,
        disabledColor: cs.surfaceContainerHighest,
        labelStyle: TextStyle(color: cs.onSurface),
        secondaryLabelStyle: TextStyle(color: cs.onSecondaryContainer),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacingMd,
          vertical: AppSizes.spacingSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        ),
      ),

      dialogTheme: DialogThemeData(
        elevation: AppSizes.elevationLg,
        backgroundColor: cs.surface,
        surfaceTintColor: cs.surfaceTint,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        ),
      ),

      switchTheme: SwitchThemeData(
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
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return cs.primary;
          }
          return cs.surfaceContainerHighest;
        }),
        checkColor: WidgetStateProperty.all(cs.onPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
        ),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return cs.primary;
          }
          return cs.outline;
        }),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: cs.inverseSurface,
        contentTextStyle: TextStyle(color: cs.onInverseSurface),
        actionTextColor: cs.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        ),
        elevation: AppSizes.elevationMd,
      ),

      bottomSheetTheme: BottomSheetThemeData(
        elevation: AppSizes.elevationXl,
        backgroundColor: cs.surface,
        surfaceTintColor: cs.surfaceTint,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.borderRadiusXl),
          ),
        ),
      ),

      drawerTheme: DrawerThemeData(
        elevation: AppSizes.elevationXl,
        backgroundColor: cs.surface,
        surfaceTintColor: cs.surfaceTint,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(AppSizes.borderRadiusXl),
          ),
        ),
      ),

      dividerTheme: DividerThemeData(
        color: cs.outlineVariant,
        thickness: 1,
        space: AppSizes.spacingMd,
      ),

      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.spacingMd,
          vertical: AppSizes.spacingSm,
        ),
      ),

      iconTheme: IconThemeData(color: cs.onSurface, size: 24),
      primaryIconTheme: IconThemeData(color: cs.primary, size: 24),
    );
  }
}
