import 'package:flutter/material.dart';

/// Slide-up + fade-in entrance animation used by card sections below the hero.
class CardEntryAnimation extends StatelessWidget {
  const CardEntryAnimation({
    super.key,
    required this.overlap,
    required this.child,
  });

  final double overlap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: const Duration(seconds: 2),
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, -overlap + (value * 120)),
          child: Opacity(
            opacity: (1.0 - value).clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
