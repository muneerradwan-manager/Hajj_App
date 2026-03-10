import 'package:equatable/equatable.dart';

/// Base state class with common fields shared across feature Cubits.
/// Extend this in feature states to avoid repeating isLoading / errorMessage / infoMessage.
abstract class BaseState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final String infoMessage;

  const BaseState({
    required this.isLoading,
    required this.errorMessage,
    required this.infoMessage,
  });
}
