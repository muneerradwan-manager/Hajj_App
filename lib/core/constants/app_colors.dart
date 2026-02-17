import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // =========================
  // Brand (main): #002623
  // =========================

  // ---------- Light ----------
  static const Color lightPrimary = Color(0xFF002623);            // #002623
  static const Color lightPrimaryContainer = Color(0xFF9FE8DE);   // soft mint tint
  static const Color lightSecondary = Color(0xFF1F4D47);          // deeper teal
  static const Color lightSecondaryContainer = Color(0xFFBFECE6); // pale teal container
  static const Color lightTertiary = Color(0xFF8A5A2B);           // warm accent (brownish-gold)
  static const Color lightError = Color(0xFFBA1A1A);
  static const Color lightErrorContainer = Color(0xFFFFDAD6);

  static const Color lightBackground = Color(0xFFF6FFFD);         // near-white with green tint
  static const Color lightSurface = Color(0xFFF6FFFD);
  static const Color lightSurfaceVariant = Color(0xFFDCE5E3);     // light green-gray

  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnSecondary = Color(0xFFFFFFFF);
  static const Color lightOnBackground = Color(0xFF0F1B19);       // very dark green-gray
  static const Color lightOnSurface = Color(0xFF0F1B19);
  static const Color lightOnError = Color(0xFFFFFFFF);

  static const Color lightOutline = Color(0xFF6F7A78);
  static const Color lightShadow = Color(0xFF000000);

  static const Color lightInverseSurface = Color(0xFF1E2B29);
  static const Color lightInversePrimary = Color(0xFF7FD0C7);
  static const Color lightSurfaceTint = Color(0xFF002623);

  // ---------- Dark ----------
  static const Color darkPrimary = Color(0xFF002623);             // readable on dark bg
  static const Color darkPrimaryContainer = Color(0xFF003B36);    // deep container
  static const Color darkSecondary = Color(0xFF1F4D47);
  static const Color darkSecondaryContainer = Color(0xFF123E39);
  static const Color darkTertiary = Color(0xFFFFB77B);            // warm accent on dark
  static const Color darkError = Color(0xFFFFB4AB);
  static const Color darkErrorContainer = Color(0xFF93000A);

  static const Color darkBackground = Color(0xFF0B1413);
  static const Color darkSurface = Color(0xFF0B1413);
  static const Color darkSurfaceVariant = Color(0xFF3F4947);      // dark green-gray

  static const Color darkOnPrimary = Color(0xFF001311);
  static const Color darkOnSecondary = Color(0xFF001311);
  static const Color darkOnBackground = Color(0xFFE1EDEA);
  static const Color darkOnSurface = Color(0xFFE1EDEA);
  static const Color darkOnError = Color(0xFF690005);

  static const Color darkOutline = Color(0xFF879391);
  static const Color darkShadow = Color(0xFF000000);

  static const Color darkInverseSurface = Color(0xFFE1EDEA);
  static const Color darkInversePrimary = Color(0xFF002623);
  static const Color darkSurfaceTint = Color(0xFF7FD0C7);
}
