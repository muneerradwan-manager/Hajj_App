import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class DirectionalBackArrow extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;
  final double? size;

  const DirectionalBackArrow({
    super.key,
    this.onPressed,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final iconData = isRtl ? LucideIcons.arrowRight : LucideIcons.arrowLeft;

    return IconButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      icon: Icon(iconData, color: color, size: size),
    );
  }
}
