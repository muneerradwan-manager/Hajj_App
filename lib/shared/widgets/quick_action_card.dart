import 'package:flutter/material.dart';

import 'package:hajj_app/shared/widgets/custom_text.dart';

/// A single quick-action card with top accent border, icon, title, and subtitle.
class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.icon,
    required this.titleKey,
    required this.subtitleKey,
    required this.accentColor,
    this.onTap,
  });

  final IconData icon;
  final String titleKey;
  final String subtitleKey;
  final Color accentColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border(
            top: BorderSide(color: accentColor, width: 3),
            bottom: BorderSide(color: accentColor),
            left: BorderSide(color: accentColor),
            right: BorderSide(color: accentColor),
          ),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          spacing: 10,
          children: [
            Container(
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
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
