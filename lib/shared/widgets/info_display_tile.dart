import 'package:flutter/material.dart';

import 'package:hajj_app/shared/widgets/custom_text.dart';

/// A soft-coloured tile that shows an icon + label row followed by a value.
/// Used in review-data cards and similar read-only displays.
class InfoDisplayTile extends StatelessWidget {
  const InfoDisplayTile({
    super.key,
    required this.icon,
    required this.labelKey,
    required this.value,
    this.trailing,
  });

  final IconData icon;
  final String labelKey;
  final String value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final content = Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 10,
          children: [
            Icon(icon, color: cs.primary.withValues(alpha: 0.7)),
            CustomText(
              labelKey,
              type: CustomTextType.bodySmall,
              color: CustomTextColor.gold,
            ),
          ],
        ),
        CustomText(
          value,
          type: CustomTextType.bodyLarge,
          color: CustomTextColor.green,
          translate: false,
        ),
      ],
    );

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: cs.surfaceDim),
        color: cs.surfaceDim.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(15),
      child: trailing != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Expanded(child: content), trailing!],
            )
          : content,
    );
  }
}
