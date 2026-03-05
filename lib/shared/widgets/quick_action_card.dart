import 'package:flutter/material.dart';

import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

import 'custom_container.dart';

/// A single quick-action card with top accent border, icon, title, and subtitle.
class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.icon,
    required this.titleKey,
    required this.subtitleKey,
    required this.borderColor,
    this.onTap,
    required this.containerColor,
  });

  final IconData icon;
  final String titleKey;
  final String subtitleKey;
  final CustomBorderColor borderColor;
  final Color containerColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        borderRadius: 10,
        padding: const EdgeInsets.all(15),
        borderSide: CustomBorderSide.borderTop,
        borderColor: borderColor,
        child: Column(
          spacing: 10,
          children: [
            CustomContainer(
              borderRadius: 10,
              containerColor: containerColor,
              padding: const EdgeInsets.all(10),
              borderWidth: 1,
              child: Icon(icon, size: 30, color: Colors.white),
            ),
            CustomText(
              titleKey,
              type: CustomTextType.bodyLarge,
              color: CustomTextColor.green,
            ),
            CustomText(
              subtitleKey,
              type: CustomTextType.labelMedium,
              color: CustomTextColor.green,
            ),
          ],
        ),
      ),
    );
  }
}
