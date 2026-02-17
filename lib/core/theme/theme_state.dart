// ============================================================
// Theme State
// ============================================================
//
// 📦 Required packages (add to pubspec.yaml):
//   - equatable: ^2.0.8   (for value comparison)
//
// 📱 Usage: This is the state class for ThemeCubit. It's immutable
//          and uses Equatable for value comparison. Use with BLoC/Cubit.
//
// ============================================================

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Immutable state class for theme management
///
/// Holds the current [ThemeMode] and uses [Equatable] for
/// efficient state comparison in BLoC rebuilds.
class ThemeState extends Equatable {
  /// Current theme mode (light, dark, or system)
  final ThemeMode themeMode;

  /// Creates a theme state with the given [themeMode]
  const ThemeState({required this.themeMode});

  /// Initial state with system theme mode
  const ThemeState.initial() : themeMode = ThemeMode.system;

  /// Creates a copy of this state with optional new values
  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  /// Props for Equatable comparison
  @override
  List<Object?> get props => [themeMode];

  @override
  String toString() => 'ThemeState(themeMode: $themeMode)';
}
