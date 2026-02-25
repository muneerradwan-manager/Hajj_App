import 'package:flutter/material.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/constants/app_colors.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: cs.surface,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          const CustomText(
            'الخدمات السريعة',
            type: CustomTextType.titleMedium,
            color: CustomTextColor.green,
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      top: BorderSide(color: cs.brandRed, width: 3),
                      bottom: BorderSide(color: cs.brandRed),
                      left: BorderSide(color: cs.brandRed),
                      right: BorderSide(color: cs.brandRed),
                    ),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    spacing: 10,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: cs.brandRed,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          LucideIcons.bookOpen,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const CustomText(
                        'مناسك الحج',
                        type: CustomTextType.bodyLarge,
                        color: CustomTextColor.green,
                      ),
                      const CustomText(
                        'تعلم مناسك الحج',
                        type: CustomTextType.labelMedium,
                        color: CustomTextColor.green,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      top: BorderSide(color: cs.primary, width: 3),
                      bottom: BorderSide(color: cs.primary),
                      left: BorderSide(color: cs.primary),
                      right: BorderSide(color: cs.primary),
                    ),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    spacing: 10,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: cs.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          LucideIcons.messageSquare,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const CustomText(
                        'استبيان الرضا',
                        type: CustomTextType.bodyLarge,
                        color: CustomTextColor.green,
                      ),
                      const CustomText(
                        'شاركنا رأيك',
                        type: CustomTextType.labelMedium,
                        color: CustomTextColor.green,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      top: BorderSide(color: cs.primary, width: 3),
                      bottom: BorderSide(color: cs.primary),
                      left: BorderSide(color: cs.primary),
                      right: BorderSide(color: cs.primary),
                    ),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    spacing: 10,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: cs.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          LucideIcons.award,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const CustomText(
                        'الشهادة',
                        type: CustomTextType.bodyLarge,
                        color: CustomTextColor.green,
                      ),
                      const CustomText(
                        'شهادة اتمام الحج',
                        type: CustomTextType.labelMedium,
                        color: CustomTextColor.green,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      top: BorderSide(color: cs.brandGold, width: 3),
                      bottom: BorderSide(color: cs.brandGold),
                      left: BorderSide(color: cs.brandGold),
                      right: BorderSide(color: cs.brandGold),
                    ),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    spacing: 10,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: cs.brandGold,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          LucideIcons.messageSquare,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const CustomText(
                        'الشكاوي',
                        type: CustomTextType.bodyLarge,
                        color: CustomTextColor.green,
                      ),
                      const CustomText(
                        'أرسل شكوى',
                        type: CustomTextType.labelMedium,
                        color: CustomTextColor.green,
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
