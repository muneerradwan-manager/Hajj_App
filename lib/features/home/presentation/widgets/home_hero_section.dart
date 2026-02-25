
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/functions/date_format.dart';
import '../../../../shared/widgets/custom_text.dart';

class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'السلام عليكم محمد',
                  textAlign: TextAlign.center,
                  type: CustomTextType.headlineSmall,
                  color: CustomTextColor.white,
                ),
                SizedBox(height: 5),
                CustomText(
                  'أهلاً بك في رحلة الحج',
                  textAlign: TextAlign.center,
                  type: CustomTextType.bodyLarge,
                  color: CustomTextColor.lightGold,
                ),
              ],
            ),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xffE5E0D6).withValues(alpha: .23),
              ),
              onPressed: () {},
              icon: const Icon(LucideIcons.bell, color: Colors.white),
            ),
          ],
        ),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Row(
                      spacing: 5,
                      children: [
                        Icon(LucideIcons.calendar, color: Colors.white),
                        CustomText(
                          'التاريخ الهجري',
                          textAlign: TextAlign.center,
                          type: CustomTextType.bodySmall,
                          color: CustomTextColor.lightGold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    CustomText(
                      getHDate(),
                      textAlign: TextAlign.center,
                      type: CustomTextType.bodyMedium,
                      color: CustomTextColor.white,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Row(
                      spacing: 5,
                      children: [
                        Icon(LucideIcons.clock, color: Colors.white),
                        CustomText(
                          'التاريخ الميلادي',
                          textAlign: TextAlign.center,
                          type: CustomTextType.bodySmall,
                          color: CustomTextColor.lightGold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    CustomText(
                      getMDate(),
                      textAlign: TextAlign.center,
                      type: CustomTextType.bodyMedium,
                      color: CustomTextColor.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
