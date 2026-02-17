// ============================================================
// Localization Cubit
// ============================================================
//
// 📦 Required packages (add to pubspec.yaml):
//   - flutter_bloc: ^9.1.1
//   - equatable: ^2.0.8
//   - shared_preferences: ^2.5.4
//
// 📱 Usage Examples:
//
//   1. Initialize and Provide at App Level:
//      ```dart
//      void main() async {
//        WidgetsFlutterBinding.ensureInitialized();
//
//        // Create cubit and load saved locale
//        final localizationCubit = LocalizationCubit();
//        await localizationCubit.loadSavedLocale();
//
//        runApp(
//          BlocProvider.value(
//            value: localizationCubit,
//            child: MyApp(),
//          ),
//        );
//      }
//      ```
//
//   2. Wire into MaterialApp with BlocBuilder:
//      ```dart
//      class MyApp extends StatelessWidget {
//        @override
//        Widget build(BuildContext context) {
//          return BlocBuilder<LocalizationCubit, LocalizationState>(
//            builder: (context, state) {
//              return MaterialApp(
//                locale: state.locale,
//                supportedLocales: AppLocalizationsSetup.supportedLocales,
//                localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
//                title: 'My App',
//                home: HomeScreen(),
//              );
//            },
//          );
//        }
//      }
//      ```
//
//   3. Change Language from Settings Screen:
//      ```dart
//      class LanguageSettingsScreen extends StatelessWidget {
//        @override
//        Widget build(BuildContext context) {
//          final localizationCubit = context.read<LocalizationCubit>();
//
//          return Scaffold(
//            appBar: AppBar(title: Text('Language')),
//            body: ListView(
//              children: [
//                ListTile(
//                  title: Text('English'),
//                  trailing: context.watch<LocalizationCubit>().state.locale.languageCode == 'en'
//                      ? Icon(Iconsax.check, color: Colors.green)
//                      : null,
//                  onTap: () => localizationCubit.changeLocale(Locale('en')),
//                ),
//                ListTile(
//                  title: Text('العربية'),
//                  trailing: context.watch<LocalizationCubit>().state.locale.languageCode == 'ar'
//                      ? Icon(Iconsax.check, color: Colors.green)
//                      : null,
//                  onTap: () => localizationCubit.changeLocale(Locale('ar')),
//                ),
//              ],
//            ),
//          );
//        }
//      }
//      ```
//
//   4. Language Switcher Dropdown:
//      ```dart
//      class LanguageDropdown extends StatelessWidget {
//        @override
//        Widget build(BuildContext context) {
//          return BlocBuilder<LocalizationCubit, LocalizationState>(
//            builder: (context, state) {
//              return DropdownButton<Locale>(
//                value: state.locale,
//                items: [
//                  DropdownMenuItem(
//                    value: Locale('en'),
//                    child: Row(
//                      children: [
//                        Text('🇺🇸', style: TextStyle(fontSize: 20)),
//                        SizedBox(width: 8),
//                        Text('English'),
//                      ],
//                    ),
//                  ),
//                  DropdownMenuItem(
//                    value: Locale('ar'),
//                    child: Row(
//                      children: [
//                        Text('🇸🇦', style: TextStyle(fontSize: 20)),
//                        SizedBox(width: 8),
//                        Text('العربية'),
//                      ],
//                    ),
//                  ),
//                ],
//                onChanged: (locale) {
//                  if (locale != null) {
//                    context.read<LocalizationCubit>().changeLocale(locale);
//                  }
//                },
//              );
//            },
//          );
//        }
//      }
//      ```
//
//   5. Get Current Locale Programmatically:
//      ```dart
//      final currentLocale = context.read<LocalizationCubit>().state.locale;
//      print('Current language: ${currentLocale.languageCode}');
//
//      // Check if RTL
//      final isRTL = Directionality.of(context) == TextDirection.rtl;
//      ```
//
// ============================================================

import 'package:flutter/material.dart';
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
      debugPrint(
        '[LocalizationCubit] Locale changed to: ${locale.languageCode}',
      );
    } catch (e) {
      debugPrint('[LocalizationCubit] Error changing locale: $e');
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
        debugPrint('[LocalizationCubit] Loaded saved locale: $languageCode');
      } else {
        debugPrint('[LocalizationCubit] No saved locale found, using default');
      }
    } catch (e) {
      debugPrint('[LocalizationCubit] Error loading saved locale: $e');
    }
  }

  /// Persists the locale to SharedPreferences
  Future<void> _saveLocale(Locale locale) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, locale.languageCode);
      debugPrint('[LocalizationCubit] Locale saved: ${locale.languageCode}');
    } catch (e) {
      debugPrint('[LocalizationCubit] Error saving locale: $e');
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
