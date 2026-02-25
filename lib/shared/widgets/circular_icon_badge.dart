import 'package:flutter/material.dart';

/// Circular badge with an icon centered inside. Used at the top of step cards.
class CircularIconBadge extends StatelessWidget {
  const CircularIconBadge({
    super.key,
    required this.icon,
    this.size = 64,
    this.iconSize = 24,
  });

  final IconData icon;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Align(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: cs.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withValues(alpha: 0.2),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Icon(icon, color: cs.onPrimary, size: iconSize),
      ),
    );
  }
}
