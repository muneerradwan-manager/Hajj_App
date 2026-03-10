import 'package:flutter/material.dart';

import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

class ComplaintsCard extends StatelessWidget {
  final int total;
  final int inReview;
  final int resolved;
  final int pending;

  const ComplaintsCard({
    super.key,
    required this.total,
    required this.inReview,
    required this.resolved,
    required this.pending,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: cs.brandGold, width: 2),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _StatColumn(
              value: total.toString(),
              labelKey: 'complaints.summary.total',
              color: CustomTextColor.green,
            ),
            VerticalDivider(color: cs.outline.withValues(alpha: .5)),
            _StatColumn(
              value: inReview.toString(),
              labelKey: 'complaints.summary.in_review',
              color: CustomTextColor.gold,
            ),
            VerticalDivider(color: cs.outline.withValues(alpha: .5)),
            _StatColumn(
              value: resolved.toString(),
              labelKey: 'complaints.summary.resolved',
              color: CustomTextColor.red,
            ),
            VerticalDivider(color: cs.outline.withValues(alpha: .5)),
            _StatColumn(
              value: pending.toString(),
              labelKey: 'complaints.summary.pending',
              color: CustomTextColor.lightGreen,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({
    required this.value,
    required this.labelKey,
    required this.color,
  });

  final String value;
  final String labelKey;
  final CustomTextColor color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          spacing: 5,
          children: [
            CustomText(
              value,
              translate: false,
              color: color,
              type: CustomTextType.titleLarge,
            ),
            CustomText(
              labelKey,
              color: CustomTextColor.hint,
              type: CustomTextType.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
