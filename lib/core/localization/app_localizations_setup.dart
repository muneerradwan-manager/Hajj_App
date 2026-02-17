// ============================================================
// App Localizations Setup - JSON-based (No Code Generation)
// ============================================================
//
// 📦 Required packages:
//   - flutter_localizations (SDK)
//   - intl: ^0.20.2
//
// 📁 Required Setup:
//
//   1. Create assets/lang/ folder in your project root
//   2. Add JSON files for each language:
//      - assets/lang/en.json
//      - assets/lang/ar.json
//      - assets/lang/es.json
//      etc.
//
//   3. Add to pubspec.yaml:
//      ```yaml
//      flutter:
//        assets:
//          - assets/lang/
//      ```
//
//   4. JSON file format (assets/lang/en.json):
//      ```json
//      {
//        "home": {
//          "title": "Home",
//          "welcome": "Welcome to our app"
//        },
//        "settings": {
//          "title": "Settings",
//          "language": "Language"
//        },
//        "common": {
//          "ok": "OK",
//          "cancel": "Cancel",
//          "save": "Save"
//        }
//      }
//      ```
//
// 📱 Usage Examples:
//
//   1. Simple translation:
//      ```dart
//      Text("home.title".tr(context))
//      ```
//
//   2. With parameters:
//      ```dart
//      Text("welcome.message".tr(context, args: {"name": "John"}))
//      // JSON: "welcome.message": "Hello, {name}!"
//      ```
//
//   3. Get current locale:
//      ```dart
//      final currentLocale = AppLocalizations.of(context).locale;
//      ```
//
//   4. MaterialApp Setup:
//      ```dart
//      MaterialApp(
//        localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
//        supportedLocales: AppLocalizationsSetup.supportedLocales,
//        locale: state.locale, // From your LocalizationCubit
//        home: HomePage(),
//      )
//      ```
//
//   5. Full Example:
//      ```dart
//      class HomePage extends StatelessWidget {
//        @override
//        Widget build(BuildContext context) {
//          return Scaffold(
//            appBar: AppBar(
//              title: Text("home.title".tr(context)),
//            ),
//            body: Column(
//              children: [
//                Text("home.welcome".tr(context)),
//                Text("welcome.message".tr(context, args: {"name": "User"})),
//                ElevatedButton(
//                  onPressed: () {},
//                  child: Text("common.ok".tr(context)),
//                ),
//              ],
//            ),
//          );
//        }
//      }
//      ```
//
// ============================================================

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Main class for app localizations
class AppLocalizations {
  final Locale locale;
  late Map<String, dynamic> _localizedStrings;

  AppLocalizations(this.locale);

  /// Get AppLocalizations instance from context
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  /// Load JSON file for the current locale
  Future<void> load() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/lang/${locale.languageCode}.json',
      );
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings = jsonMap;
    } catch (e) {
      debugPrint(
        '[AppLocalizations] Error loading locale ${locale.languageCode}: $e',
      );
      // Fallback to empty map
      _localizedStrings = {};
    }
  }

  /// Translate a key with optional parameters
  ///
  /// [key] - Dot notation key (e.g., "home.title")
  /// [args] - Optional map of parameters to replace in the string
  ///
  /// Example: translate("welcome.message", args: {"name": "John"})
  String translate(String key, {Map<String, dynamic>? args}) {
    // Split key by dots to navigate nested JSON
    final keys = key.split('.');
    dynamic value = _localizedStrings;

    // Navigate through nested structure
    for (final k in keys) {
      if (value is Map && value.containsKey(k)) {
        value = value[k];
      } else {
        // Key not found, return the key itself
        return key;
      }
    }

    // If value is not a string, return the key
    if (value is! String) {
      return key;
    }

    // Replace parameters if provided
    String result = value;
    if (args != null) {
      args.forEach((paramKey, paramValue) {
        result = result.replaceAll('{$paramKey}', paramValue.toString());
      });
    }

    return result;
  }
}

/// Delegate for loading localizations
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Add your supported language codes here
    return AppLocalizationsSetup.supportedLanguageCodes.contains(
      locale.languageCode,
    );
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

/// Extension on String for easy translation
extension TranslationExtension on String {
  /// Translate this string key using the current locale
  ///
  /// [context] - BuildContext to get current locale
  /// [args] - Optional parameters to replace in the translated string
  ///
  /// Example: "home.title".tr(context)
  /// Example with params: "welcome.message".tr(context, args: {"name": "John"})
  String tr(BuildContext context, {Map<String, dynamic>? args}) {
    return AppLocalizations.of(context).translate(this, args: args);
  }
}

/// Setup class with supported locales and delegates
class AppLocalizationsSetup {
  AppLocalizationsSetup._();

  /// List of supported language codes
  /// Add more language codes as you add JSON files
  static const List<String> supportedLanguageCodes = [
    'en', // English
    'ar', // Arabic
    'es', // Spanish
    'fr', // French
    'de', // German
    'it', // Italian
    'pt', // Portuguese
    'ru', // Russian
    'zh', // Chinese
    'ja', // Japanese
    'ko', // Korean
  ];

  /// List of supported locales
  static List<Locale> get supportedLocales {
    return supportedLanguageCodes.map((code) => Locale(code)).toList();
  }

  /// List of localization delegates
  /// Use this in MaterialApp's localizationsDelegates parameter
  static const List<LocalizationsDelegate> localizationsDelegates = [
    AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  /// Get language name in its native form
  static String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'ar':
        return 'العربية';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      case 'de':
        return 'Deutsch';
      case 'it':
        return 'Italiano';
      case 'pt':
        return 'Português';
      case 'ru':
        return 'Русский';
      case 'zh':
        return '中文';
      case 'ja':
        return '日本語';
      case 'ko':
        return '한국어';
      default:
        return locale.languageCode.toUpperCase();
    }
  }

  /// Get flag emoji for locale
  static String getLanguageFlag(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return '🇺🇸';
      case 'ar':
        return '🇸🇦';
      case 'es':
        return '🇪🇸';
      case 'fr':
        return '🇫🇷';
      case 'de':
        return '🇩🇪';
      case 'it':
        return '🇮🇹';
      case 'pt':
        return '🇵🇹';
      case 'ru':
        return '🇷🇺';
      case 'zh':
        return '🇨🇳';
      case 'ja':
        return '🇯🇵';
      case 'ko':
        return '🇰🇷';
      default:
        return '🌐';
    }
  }

  /// Check if locale uses right-to-left text direction
  static bool isRTL(Locale locale) {
    return ['ar', 'he', 'fa', 'ur'].contains(locale.languageCode);
  }

  /// Get text direction for locale
  static TextDirection getTextDirection(Locale locale) {
    return isRTL(locale) ? TextDirection.rtl : TextDirection.ltr;
  }
}
