import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DirectionalBackArrow extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;

  const DirectionalBackArrow({super.key, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final iconData = isRtl ? Iconsax.arrow_right_1 : Iconsax.arrow_left;

    return IconButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      icon: Icon(iconData, color: color),
    );
  }
}
