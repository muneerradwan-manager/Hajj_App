import 'package:flutter/material.dart';

/// Reusable card container used across auth and home screens.
///
/// Wraps content in a rounded, bordered surface with optional shadow.
class AppCardContainer extends StatelessWidget {
  const AppCardContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 14.0,
    this.borderColor,
    this.showShadow = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color? borderColor;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor ?? cs.outlineVariant),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: cs.shadow.withValues(alpha: 0.18),
                  blurRadius: 28,
                  offset: const Offset(0, 14),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
