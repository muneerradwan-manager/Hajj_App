// ============================================================
// Localization State
// ============================================================
//
// 📦 Required packages (add to pubspec.yaml):
//   - equatable: ^2.0.8
//   - flutter_bloc: ^9.1.1
//
// 📱 Usage:
//   This state is used internally by LocalizationCubit.
//   It holds the current locale and is immutable for predictable state changes.
//
//   Example:
//   ```dart
//   final state = LocalizationState(locale: Locale('en'));
//   print(state.locale.languageCode); // 'en'
//   ```
//
// ============================================================

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Immutable state class for localization management
///
/// Holds the current [Locale] being used by the application.
/// Uses [Equatable] for value comparison in BLoC state changes.
@immutable
class LocalizationState extends Equatable {
  /// The current locale of the application
  final Locale locale;

  /// Creates a [LocalizationState] with the given [locale]
  const LocalizationState({required this.locale});

  /// Default state with Arabic locale
  factory LocalizationState.initial() {
    return const LocalizationState(locale: Locale('ar'));
  }

  /// Creates a copy of this state with the given fields replaced
  LocalizationState copyWith({Locale? locale}) {
    return LocalizationState(locale: locale ?? this.locale);
  }

  @override
  List<Object?> get props => [locale];

  @override
  String toString() => 'LocalizationState(locale: ${locale.languageCode})';
}
