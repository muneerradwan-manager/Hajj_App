import 'package:flutter/material.dart';
import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../shared/widgets/custom_text.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: cs.primaryContainer),
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
        children: [
          Container(
            height: 5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [cs.brandRed, cs.primary, cs.brandGold],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              spacing: 10,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: cs.primary,
                    border: Border.all(color: cs.brandGold, width: 3),
                  ),
                  child: Icon(LucideIcons.user, size: 48, color: cs.onPrimary),
                ),
                Expanded(
                  child: Column(
                    spacing: 12,
                    children: [
                      const CustomText(
                        'محمد أحمد الشامي',
                        textAlign: TextAlign.center,
                        type: CustomTextType.bodyLarge,
                        color: CustomTextColor.green,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: cs.primary.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: cs.primary.withValues(alpha: .3),
                          ),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: const CustomText(
                          'SYR-2026-4521',
                          textAlign: TextAlign.center,
                          type: CustomTextType.bodyMedium,
                          color: CustomTextColor.lightGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Divider(color: cs.brandGold, thickness: 1, height: 0),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cs.primary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              spacing: 10,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: cs.brandGold.withValues(alpha: .1),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 10,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: cs.brandRed,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: const Icon(
                                LucideIcons.layers,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            const CustomText(
                              'التكتل',
                              type: CustomTextType.bodyMedium,
                              color: CustomTextColor.gold,
                            ),
                          ],
                        ),
                        const CustomText(
                          'ارتقاء',
                          type: CustomTextType.bodyMedium,
                          color: CustomTextColor.lightGreen,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: cs.brandGold.withValues(alpha: .1),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 10,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: cs.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: const Icon(
                                LucideIcons.grid3x3,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            const CustomText(
                              'المجموعة',
                              type: CustomTextType.bodyMedium,
                              color: CustomTextColor.gold,
                            ),
                          ],
                        ),
                        const CustomText(
                          'التوفيق',
                          type: CustomTextType.bodyMedium,
                          color: CustomTextColor.lightGreen,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const CustomText(
                'عرض البطاقة الكاملة',
                color: CustomTextColor.white,
              ),
            ),
          ),
          Container(
            height: 5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [cs.brandRed, cs.primary, cs.brandGold],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
