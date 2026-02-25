import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/custom_text.dart';

class PrayerTimes extends StatelessWidget {
  const PrayerTimes({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cs.primary),
        color: cs.surface,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        spacing: 20,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                'مواقيت الصلاة',
                type: CustomTextType.titleMedium,
                color: CustomTextColor.green,
              ),
              CustomText(
                'مكة المكرمة',
                type: CustomTextType.titleSmall,
                color: CustomTextColor.gold,
              ),
            ],
          ),
          Row(
            spacing: 5,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: cs.brandGold),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const Column(
                    spacing: 10,
                    children: [
                      CustomText(
                        'الفجر',
                        type: CustomTextType.labelSmall,
                        color: CustomTextColor.green,
                      ),
                      CustomText(
                        '04:45',
                        type: CustomTextType.bodySmall,
                        color: CustomTextColor.gold,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: cs.brandGold),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const Column(
                    spacing: 10,
                    children: [
                      CustomText(
                        'الظهر',
                        type: CustomTextType.labelSmall,
                        color: CustomTextColor.green,
                      ),
                      CustomText(
                        '04:45',
                        type: CustomTextType.bodySmall,
                        color: CustomTextColor.gold,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: cs.primary),
                    color: cs.primary,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const Column(
                    spacing: 10,
                    children: [
                      CustomText(
                        'العصر',
                        type: CustomTextType.labelSmall,
                        color: CustomTextColor.white,
                      ),
                      CustomText(
                        '04:45',
                        type: CustomTextType.bodySmall,
                        color: CustomTextColor.white,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: cs.brandGold),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const Column(
                    spacing: 10,
                    children: [
                      CustomText(
                        'المغرب',
                        type: CustomTextType.labelSmall,
                        color: CustomTextColor.green,
                      ),
                      CustomText(
                        '04:45',
                        type: CustomTextType.bodySmall,
                        color: CustomTextColor.gold,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: cs.brandGold),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const Column(
                    spacing: 10,
                    children: [
                      CustomText(
                        'العشاء',
                        type: CustomTextType.labelSmall,
                        color: CustomTextColor.green,
                      ),
                      CustomText(
                        '04:45',
                        type: CustomTextType.bodySmall,
                        color: CustomTextColor.gold,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
