import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../shared/widgets/custom_text.dart';

class ArafatTimeLift extends StatelessWidget {
  const ArafatTimeLift({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [cs.brandRed, cs.brandRedAlt],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 20,
          children: [
            const CustomText(
              'الوقت المتبقي ليوم عرفة',
              type: CustomTextType.titleMedium,
              color: CustomTextColor.lightGold,
            ),
            Row(
              spacing: 5,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: .23),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Column(
                      children: [
                        CustomText(
                          '00',
                          type: CustomTextType.titleMedium,
                          color: CustomTextColor.white,
                        ),
                        CustomText(
                          'يوم',
                          type: CustomTextType.bodyMedium,
                          color: CustomTextColor.lightGold,
                        ),
                      ],
                    ),
                  ),
                ),
                const CustomText(':', color: CustomTextColor.white),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: .23),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Column(
                      children: [
                        CustomText(
                          '00',
                          type: CustomTextType.titleMedium,
                          color: CustomTextColor.white,
                        ),
                        CustomText(
                          'ساعة',
                          type: CustomTextType.bodyMedium,
                          color: CustomTextColor.lightGold,
                        ),
                      ],
                    ),
                  ),
                ),
                const CustomText(':', color: CustomTextColor.white),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: .23),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Column(
                      children: [
                        CustomText(
                          '00',
                          type: CustomTextType.titleMedium,
                          color: CustomTextColor.white,
                        ),
                        CustomText(
                          'دقيقة',
                          type: CustomTextType.bodyMedium,
                          color: CustomTextColor.lightGold,
                        ),
                      ],
                    ),
                  ),
                ),
                const CustomText(':', color: CustomTextColor.white),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: .23),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Column(
                      children: [
                        CustomText(
                          '00',
                          type: CustomTextType.titleMedium,
                          color: CustomTextColor.white,
                        ),
                        CustomText(
                          'ثانية',
                          type: CustomTextType.bodyMedium,
                          color: CustomTextColor.lightGold,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
