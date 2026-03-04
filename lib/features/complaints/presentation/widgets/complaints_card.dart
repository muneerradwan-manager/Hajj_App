import 'package:flutter/material.dart';

import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ComplaintsCard extends StatelessWidget {
  const ComplaintsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: cs.brandGold),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.18),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20,
        children: [
          _GoldStripe(cs: cs),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: cs.brandGold),
                borderRadius: BorderRadius.circular(20),
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
                              color: CustomTextColor.red,
                              type: CustomTextType.titleLarge,
                            ),
                            CustomText(
                              'إجمالي',
                              color: CustomTextColor.hint,
                              type: CustomTextType.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(color: cs.outline),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          spacing: 5,
                          children: [
                            CustomText(
                              '1',
                              color: CustomTextColor.gold,
                              type: CustomTextType.titleLarge,
                            ),
                            CustomText(
                              'قيد المراجعة',
                              color: CustomTextColor.hint,
                              type: CustomTextType.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(color: cs.outline),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          spacing: 5,
                          children: [
                            CustomText(
                              '1',
                              color: CustomTextColor.green,
                              type: CustomTextType.titleLarge,
                            ),
                            CustomText(
                              'تم الحل',
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [cs.brandRed, cs.brandRedAlt],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {},
                icon: const Icon(LucideIcons.plus),
                label: const CustomText(
                  'تقديم شكوى جديدة',
                  color: CustomTextColor.white,
                ),
              ),
            ),
          ),
          _GoldStripe(cs: cs),
        ],
      ),
    );
  }
}

class _GoldStripe extends StatelessWidget {
  const _GoldStripe({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(height: 5, decoration: BoxDecoration(color: cs.brandGold));
  }
}
