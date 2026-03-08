import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_localizations_setup.dart';
import 'localization_state.dart';

/// Cubit for managing application localization
///
/// Handles locale changes and persists the selected locale to SharedPreferences.
/// The locale preference survives app restarts.
class LocalizationCubit extends Cubit<LocalizationState> {
  static const String _localeKey = 'app_locale';

  /// Creates a [LocalizationCubit] with Arabic as the default locale
  LocalizationCubit() : super(LocalizationState.initial());

  void _log(String message) {
    if (kDebugMode) debugPrint(message);
  }

  /// Changes the current locale and persists it to storage
  ///
  /// [locale] - The new locale to set (e.g., Locale('en'), Locale('ar'))
  ///
  /// This will trigger a rebuild of all widgets listening to this cubit.
  /// The MaterialApp will automatically update its locale and rebuild with
  /// the new language strings.
  Future<void> changeLocale(Locale locale) async {
    try {
      emit(state.copyWith(locale: locale));
      await _saveLocale(locale);
      _log('[LocalizationCubit] Locale changed to: ${locale.languageCode}');
    } catch (e) {
      _log('[LocalizationCubit] Error changing locale: $e');
    }
  }

  /// Loads the saved locale from SharedPreferences
  ///
  /// Call this method during app initialization (before runApp) to restore
  /// the user's language preference.
  ///
  /// If no saved locale exists, the current state (default Arabic) is kept.
  Future<void> loadSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_localeKey);

      if (languageCode != null &&
          AppLocalizationsSetup.supportedLanguageCodes.contains(languageCode)) {
        final savedLocale = Locale(languageCode);
        emit(state.copyWith(locale: savedLocale));
        _log('[LocalizationCubit] Loaded saved locale: $languageCode');
      } else {
        _log('[LocalizationCubit] No saved locale found, using default');
      }
    } catch (e) {
      _log('[LocalizationCubit] Error loading saved locale: $e');
    }
  }

  /// Persists the locale to SharedPreferences
  Future<void> _saveLocale(Locale locale) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, locale.languageCode);
      _log('[LocalizationCubit] Locale saved: ${locale.languageCode}');
    } catch (e) {
      _log('[LocalizationCubit] Error saving locale: $e');
    }
  }

  /// Gets the current locale
  ///
  /// Convenience getter for accessing the current locale without
  /// accessing the state directly.
  Locale get currentLocale => state.locale;

  /// Checks if the current locale is RTL (Right-to-Left)
  ///
  /// Currently checks for Arabic. Add more RTL language codes as needed
  /// (e.g., 'he' for Hebrew, 'fa' for Farsi, 'ur' for Urdu).
  bool get isRTL {
    final rtlLanguages = ['ar', 'he', 'fa', 'ur'];
    return rtlLanguages.contains(state.locale.languageCode);
  }
}
