// ============================================================
// App Theme
// ============================================================
//
// 📦 Required packages:
//   - flutter SDK (Material 3 built-in)
//
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/core/constants/app_sizes.dart';

/// App-wide theme configuration with Material 3 support
///
/// Provides comprehensive theming for light and dark modes with
/// consistent colors, typography, spacing, and component styles.
class AppTheme {
  AppTheme._(); // Prevent instantiation

  // Choose your Google Font here
  static const String _fontFamily = 'Cairo';

  // ============================================================
  // TEXT THEME (shared) - Google Fonts
  // ============================================================

  static TextTheme _textTheme(ColorScheme cs) {
    // Base Google font text theme (Material 3)
    final base = GoogleFonts.getTextTheme(_fontFamily);

    // Apply your colors + weights on top
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

  // ============================================================
  // LIGHT THEME
  // ============================================================

  static ThemeData get lightTheme {
    final cs = const ColorScheme.light(
      primary: AppColors.lightPrimary,
      primaryContainer: AppColors.lightPrimaryContainer,
      secondary: AppColors.lightSecondary,
      secondaryContainer: AppColors.lightSecondaryContainer,
      tertiary: AppColors.lightTertiary,
      error: AppColors.lightError,
      errorContainer: AppColors.lightErrorContainer,
      surface: AppColors.lightSurface,
      surfaceContainerHighest: AppColors.lightSurfaceVariant,
      onPrimary: AppColors.lightOnPrimary,
      onSecondary: AppColors.lightOnSecondary,
      onSurface: AppColors.lightOnSurface,
      onError: AppColors.lightOnError,
      outline: AppColors.lightOutline,
      shadow: AppColors.lightShadow,
      inverseSurface: AppColors.lightInverseSurface,
      inversePrimary: AppColors.lightInversePrimary,
      surfaceTint: AppColors.lightSurfaceTint,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: cs,
      scaffoldBackgroundColor: AppColors.lightBackground,
      textTheme: _textTheme(cs),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        elevation: AppSizes.elevationSm,
        centerTitle: false,
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightOnSurface,
        surfaceTintColor: AppColors.lightSurfaceTint,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: AppColors.lightOnSurface,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: AppSizes.elevationSm,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        ),
        color: AppColors.lightSurface,
        surfaceTintColor: AppColors.lightSurfaceTint,
      ),

      // Elevated Button Theme
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

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacingLg,
            vertical: AppSizes.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          ),
          side: const BorderSide(color: AppColors.lightOutline),
          minimumSize: const Size(64, 48),
        ),
      ),

      // Text Button Theme
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

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: AppSizes.elevationMd,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusXl),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurfaceVariant.withValues(alpha: 0.3),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacingMd,
          vertical: AppSizes.spacingMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          borderSide: const BorderSide(color: AppColors.lightOutline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          borderSide: const BorderSide(color: AppColors.lightOutline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          borderSide: const BorderSide(color: AppColors.lightPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          borderSide: const BorderSide(color: AppColors.lightError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          borderSide: const BorderSide(color: AppColors.lightError, width: 2),
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: AppSizes.elevationMd,
        backgroundColor: AppColors.lightSurface,
        selectedItemColor: AppColors.lightPrimary,
        unselectedItemColor: AppColors.lightOutline,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      // Navigation Bar Theme (Material 3 style)
      navigationBarTheme: NavigationBarThemeData(
        elevation: AppSizes.elevationSm,
        backgroundColor: AppColors.lightSurface,
        indicatorColor: AppColors.lightPrimaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.lightOnSurface,
            );
          }
          return const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.lightOutline,
          );
        }),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightSurfaceVariant,
        selectedColor: AppColors.lightSecondaryContainer,
        disabledColor: AppColors.lightSurfaceVariant.withValues(alpha: 0.5),
        labelStyle: const TextStyle(color: AppColors.lightOnSurface),
        secondaryLabelStyle: const TextStyle(color: AppColors.lightOnSecondary),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacingMd,
          vertical: AppSizes.spacingSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        elevation: AppSizes.elevationLg,
        backgroundColor: AppColors.lightSurface,
        surfaceTintColor: AppColors.lightSurfaceTint,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        ),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightOnPrimary;
          }
          return AppColors.lightOutline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightPrimary;
          }
          return AppColors.lightSurfaceVariant;
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightPrimary;
          }
          return AppColors.lightSurfaceVariant;
        }),
        checkColor: WidgetStateProperty.all(AppColors.lightOnPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
        ),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.lightPrimary;
          }
          return AppColors.lightOutline;
        }),
      ),

      // SnackBar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.lightInverseSurface,
        contentTextStyle: const TextStyle(color: AppColors.lightInversePrimary),
        actionTextColor: AppColors.lightSecondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        ),
        elevation: AppSizes.elevationMd,
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        elevation: AppSizes.elevationXl,
        backgroundColor: AppColors.lightSurface,
        surfaceTintColor: AppColors.lightSurfaceTint,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.borderRadiusXl),
          ),
        ),
      ),

      // Drawer Theme
      drawerTheme: DrawerThemeData(
        elevation: AppSizes.elevationXl,
        backgroundColor: AppColors.lightSurface,
        surfaceTintColor: AppColors.lightSurfaceTint,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(AppSizes.borderRadiusXl),
          ),
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.lightOutline,
        thickness: 1,
        space: AppSizes.spacingMd,
      ),

      // List Tile Theme
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.spacingMd,
          vertical: AppSizes.spacingSm,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: AppColors.lightOnSurface, size: 24),

      // Primary Icon Theme
      primaryIconTheme: const IconThemeData(
        color: AppColors.lightPrimary,
        size: 24,
      ),
    );
  }

  // ============================================================
  // DARK THEME
  // ============================================================

  static ThemeData get darkTheme {
    final cs = const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      primaryContainer: AppColors.darkPrimaryContainer,
      secondary: AppColors.darkSecondary,
      secondaryContainer: AppColors.darkSecondaryContainer,
      tertiary: AppColors.darkTertiary,
      error: AppColors.darkError,
      errorContainer: AppColors.darkErrorContainer,
      surface: AppColors.darkSurface,
      surfaceContainerHighest: AppColors.darkSurfaceVariant,
      onPrimary: AppColors.darkOnPrimary,
      onSecondary: AppColors.darkOnSecondary,
      onSurface: AppColors.darkOnSurface,
      onError: AppColors.darkOnError,
      outline: AppColors.darkOutline,
      shadow: AppColors.darkShadow,
      inverseSurface: AppColors.darkInverseSurface,
      inversePrimary: AppColors.darkInversePrimary,
      surfaceTint: AppColors.darkSurfaceTint,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: cs,
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: _textTheme(cs),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        elevation: AppSizes.elevationSm,
        centerTitle: false,
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkOnSurface,
        surfaceTintColor: AppColors.darkSurfaceTint,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: AppColors.darkOnSurface,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: AppSizes.elevationSm,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        ),
        color: AppColors.darkSurface,
        surfaceTintColor: AppColors.darkSurfaceTint,
      ),

      // Elevated Button Theme
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

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacingLg,
            vertical: AppSizes.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          ),
          side: const BorderSide(color: AppColors.darkOutline),
          minimumSize: const Size(64, 48),
        ),
      ),

      // Text Button Theme
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

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: AppSizes.elevationMd,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusXl),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceVariant.withValues(alpha: 0.3),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacingMd,
          vertical: AppSizes.spacingMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          borderSide: const BorderSide(color: AppColors.darkOutline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          borderSide: const BorderSide(color: AppColors.darkOutline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          borderSide: const BorderSide(color: AppColors.darkPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          borderSide: const BorderSide(color: AppColors.darkError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          borderSide: const BorderSide(color: AppColors.darkError, width: 2),
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: AppSizes.elevationMd,
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.darkPrimary,
        unselectedItemColor: AppColors.darkOutline,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      // Navigation Bar Theme (Material 3 style)
      navigationBarTheme: NavigationBarThemeData(
        elevation: AppSizes.elevationSm,
        backgroundColor: AppColors.darkSurface,
        indicatorColor: AppColors.darkPrimaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.darkOnSurface,
            );
          }
          return const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.darkOutline,
          );
        }),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkSurfaceVariant,
        selectedColor: AppColors.darkSecondaryContainer,
        disabledColor: AppColors.darkSurfaceVariant.withValues(alpha: 0.5),
        labelStyle: const TextStyle(color: AppColors.darkOnSurface),
        secondaryLabelStyle: const TextStyle(color: AppColors.darkOnSecondary),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacingMd,
          vertical: AppSizes.spacingSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        elevation: AppSizes.elevationLg,
        backgroundColor: AppColors.darkSurface,
        surfaceTintColor: AppColors.darkSurfaceTint,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        ),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkOnPrimary;
          }
          return AppColors.darkOutline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkPrimary;
          }
          return AppColors.darkSurfaceVariant;
        }),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkPrimary;
          }
          return AppColors.darkSurfaceVariant;
        }),
        checkColor: WidgetStateProperty.all(AppColors.darkOnPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
        ),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkPrimary;
          }
          return AppColors.darkOutline;
        }),
      ),

      // SnackBar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkInverseSurface,
        contentTextStyle: const TextStyle(color: AppColors.darkInversePrimary),
        actionTextColor: AppColors.darkSecondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
        ),
        elevation: AppSizes.elevationMd,
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        elevation: AppSizes.elevationXl,
        backgroundColor: AppColors.darkSurface,
        surfaceTintColor: AppColors.darkSurfaceTint,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.borderRadiusXl),
          ),
        ),
      ),

      // Drawer Theme
      drawerTheme: DrawerThemeData(
        elevation: AppSizes.elevationXl,
        backgroundColor: AppColors.darkSurface,
        surfaceTintColor: AppColors.darkSurfaceTint,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(AppSizes.borderRadiusXl),
          ),
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.darkOutline,
        thickness: 1,
        space: AppSizes.spacingMd,
      ),

      // List Tile Theme
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.spacingMd,
          vertical: AppSizes.spacingSm,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: AppColors.darkOnSurface, size: 24),

      // Primary Icon Theme
      primaryIconTheme: const IconThemeData(
        color: AppColors.darkPrimary,
        size: 24,
      ),
    );
  }
}
