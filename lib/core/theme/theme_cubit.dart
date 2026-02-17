// ============================================================
// Theme Cubit
// ============================================================
//
// 📦 Required packages (add to pubspec.yaml):
//   - flutter_bloc: ^9.1.1
//   - shared_preferences: ^2.5.4
//   - equatable: ^2.0.8
//
// 📱 Usage Examples:
//
//   1. Setup in main.dart:
//      ```dart
//      void main() async {
//        WidgetsFlutterBinding.ensureInitialized();
//        await SharedPreferences.getInstance();
//
//        runApp(
//          BlocProvider(
//            create: (context) => ThemeCubit()..loadSavedTheme(),
//            child: const MyApp(),
//          ),
//        );
//      }
//      ```
//
//   2. Wire into MaterialApp:
//      ```dart
//      class MyApp extends StatelessWidget {
//        const MyApp({super.key});
//
//        @override
//        Widget build(BuildContext context) {
//          return BlocBuilder<ThemeCubit, ThemeState>(
//            builder: (context, state) {
//              return MaterialApp(
//                title: 'My App',
//                theme: AppTheme.lightTheme,
//                darkTheme: AppTheme.darkTheme,
//                themeMode: state.themeMode,
//                home: const HomePage(),
//              );
//            },
//          );
//        }
//      }
//      ```
//
//   3. Toggle theme in settings:
//      ```dart
//      class ThemeToggleWidget extends StatelessWidget {
//        const ThemeToggleWidget({super.key});
//
//        @override
//        Widget build(BuildContext context) {
//          return BlocBuilder<ThemeCubit, ThemeState>(
//            builder: (context, state) {
//              return Column(
//                children: [
//                  // Simple toggle button
//                  ElevatedButton(
//                    onPressed: () {
//                      context.read<ThemeCubit>().toggleTheme();
//                    },
//                    child: Text(
//                      'Current: ${state.themeMode.name}',
//                    ),
//                  ),
//
//                  // Radio buttons for all modes
//                  RadioListTile<ThemeMode>(
//                    title: const Text('Light'),
//                    value: ThemeMode.light,
//                    groupValue: state.themeMode,
//                    onChanged: (mode) {
//                      if (mode != null) {
//                        context.read<ThemeCubit>().setThemeMode(mode);
//                      }
//                    },
//                  ),
//                  RadioListTile<ThemeMode>(
//                    title: const Text('Dark'),
//                    value: ThemeMode.dark,
//                    groupValue: state.themeMode,
//                    onChanged: (mode) {
//                      if (mode != null) {
//                        context.read<ThemeCubit>().setThemeMode(mode);
//                      }
//                    },
//                  ),
//                  RadioListTile<ThemeMode>(
//                    title: const Text('System'),
//                    value: ThemeMode.system,
//                    groupValue: state.themeMode,
//                    onChanged: (mode) {
//                      if (mode != null) {
//                        context.read<ThemeCubit>().setThemeMode(mode);
//                      }
//                    },
//                  ),
//                ],
//              );
//            },
//          );
//        }
//      }
//      ```
//
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_state.dart';

/// Cubit for managing app theme mode with persistence
///
/// Handles theme mode changes and automatically saves preferences
/// to SharedPreferences for persistence across app restarts.
class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeModeKey = 'theme_mode';

  /// Creates a ThemeCubit with initial system theme mode
  ThemeCubit() : super(const ThemeState.initial());

  /// Toggles between light and dark theme modes
  ///
  /// Cycles: light → dark → light
  /// If current mode is system, switches to light first.
  void toggleTheme() {
    final ThemeMode newMode;

    switch (state.themeMode) {
      case ThemeMode.light:
        newMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        newMode = ThemeMode.light;
        break;
      case ThemeMode.system:
        newMode = ThemeMode.light;
        break;
    }

    setThemeMode(newMode);
  }

  /// Sets the theme mode to a specific value
  ///
  /// Supports [ThemeMode.light], [ThemeMode.dark], and [ThemeMode.system].
  /// Automatically saves the preference to SharedPreferences.
  void setThemeMode(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
    _saveThemeMode(mode);
  }

  /// Loads the saved theme mode from SharedPreferences
  ///
  /// Should be called during app initialization to restore
  /// the user's theme preference. If no saved preference exists,
  /// defaults to system theme mode.
  Future<void> loadSavedTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedMode = prefs.getString(_themeModeKey);

      if (savedMode != null) {
        final ThemeMode mode;
        switch (savedMode) {
          case 'light':
            mode = ThemeMode.light;
            break;
          case 'dark':
            mode = ThemeMode.dark;
            break;
          case 'system':
            mode = ThemeMode.system;
            break;
          default:
            mode = ThemeMode.system;
        }
        emit(state.copyWith(themeMode: mode));
      }
    } catch (e) {
      debugPrint('[ThemeCubit] Error loading saved theme: $e');
      // Keep default system theme on error
    }
  }

  /// Saves the theme mode to SharedPreferences
  Future<void> _saveThemeMode(ThemeMode mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String modeString;

      switch (mode) {
        case ThemeMode.light:
          modeString = 'light';
          break;
        case ThemeMode.dark:
          modeString = 'dark';
          break;
        case ThemeMode.system:
          modeString = 'system';
          break;
      }

      await prefs.setString(_themeModeKey, modeString);
      debugPrint('[ThemeCubit] Saved theme mode: $modeString');
    } catch (e) {
      debugPrint('[ThemeCubit] Error saving theme mode: $e');
    }
  }
}
