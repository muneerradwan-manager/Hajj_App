import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/shared/widgets/custom_text.dart';

import '../../../../shared/widgets/custom_container.dart';
import '../../../../shared/widgets/directional_back_arrow.dart';

class ComplaintDetailsHeroSection extends StatelessWidget {
  const ComplaintDetailsHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top + 20),
        Row(
          children: [
            DirectionalBackArrow(
              color: Colors.white,
              onPressed: () {
                context.pop();
              },
            ),
            const CustomText(
              'profile.back',
              textAlign: TextAlign.center,
              type: CustomTextType.bodyLarge,
              color: CustomTextColor.white,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: .3),
            border: Border.all(color: Colors.white.withValues(alpha: .5)),
          ),
          child: IconButton(
            icon: const Icon(LucideIcons.hotel, color: Colors.white),
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 10),
        const CustomText(
          'complaints.details.category_meals',
          color: CustomTextColor.white,
          type: CustomTextType.headlineSmall,
        ),
        const SizedBox(height: 10),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: CustomContainer(
                borderWidth: 1,
                borderSide: CustomBorderSide.allBorder,
                borderColor: CustomBorderColor.white,
                hasOpacity: 0.2,
                hasShadow: false,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                borderHasOpacity: 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 5,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: cs.primary,
                          ),
                        ),
                        const CustomText(
                          'complaints.details.created_at',
                          color: CustomTextColor.white,
                          type: CustomTextType.labelMedium,
                        ),
                      ],
                    ),
                    const CustomText(
                      '2026-02-28',
                      color: CustomTextColor.white,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: CustomContainer(
                borderWidth: 1,
                borderSide: CustomBorderSide.allBorder,
                borderColor: CustomBorderColor.white,
                hasOpacity: 0.2,
                hasShadow: false,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                borderHasOpacity: 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 5,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: cs.brandGold,
                          ),
                        ),
                        const CustomText(
                          'complaints.details.updated_at',
                          color: CustomTextColor.white,
                          type: CustomTextType.labelMedium,
                        ),
                      ],
                    ),
                    const CustomText(
                      '2026-03-01',
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
