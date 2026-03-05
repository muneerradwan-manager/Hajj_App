import 'package:flutter/material.dart';

import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

class ComplaintsCard extends StatelessWidget {
  const ComplaintsCard({super.key});

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
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  spacing: 5,
                  children: [
                    CustomText(
                      '3',
                      translate: false,
                      color: CustomTextColor.green,
                      type: CustomTextType.titleLarge,
                    ),
                    CustomText(
                      'complaints.summary.total',
                      color: CustomTextColor.hint,
                      type: CustomTextType.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(color: cs.outline.withValues(alpha: .5)),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  spacing: 5,
                  children: [
                    CustomText(
                      '1',
                      translate: false,
                      color: CustomTextColor.gold,
                      type: CustomTextType.titleLarge,
                    ),
                    CustomText(
                      'complaints.summary.in_review',
                      color: CustomTextColor.hint,
                      type: CustomTextType.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(color: cs.outline.withValues(alpha: .5)),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  spacing: 5,
                  children: [
                    CustomText(
                      '1',
                      translate: false,
                      color: CustomTextColor.red,
                      type: CustomTextType.titleLarge,
                    ),
                    CustomText(
                      'complaints.summary.resolved',
                      color: CustomTextColor.hint,
                      type: CustomTextType.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(color: cs.outline.withValues(alpha: .5)),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  spacing: 5,
                  children: [
                    CustomText(
                      '1',
                      translate: false,
                      color: CustomTextColor.lightGreen,
                      type: CustomTextType.titleLarge,
                    ),
                    CustomText(
                      'complaints.summary.pending',
                      color: CustomTextColor.hint,
                      type: CustomTextType.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
