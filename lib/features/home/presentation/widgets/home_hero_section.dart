import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/core/functions/date_format.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';

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
                  'home.greeting',
                  args: {'name': 'محمد'},
                  textAlign: TextAlign.center,
                  type: CustomTextType.headlineSmall,
                  color: CustomTextColor.white,
                ),
                SizedBox(height: 5),
                CustomText(
                  'home.welcome_subtitle',
                  textAlign: TextAlign.center,
                  type: CustomTextType.bodyLarge,
                  color: CustomTextColor.lightGold,
                ),
              ],
            ),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: AppColors.overlay.withValues(alpha: .23),
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
              child: _DateCard(
                icon: LucideIcons.calendar,
                labelKey: 'home.hijri_date',
                value: getHDate(),
              ),
            ),
            Expanded(
              child: _DateCard(
                icon: LucideIcons.clock,
                labelKey: 'home.gregorian_date',
                value: getMDate(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DateCard extends StatelessWidget {
  const _DateCard({
    required this.icon,
    required this.labelKey,
    required this.value,
  });

  final IconData icon;
  final String labelKey;
  final String value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white.withValues(alpha: 0.2),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            spacing: 5,
            children: [
              Icon(icon, color: cs.surfaceDim),
              CustomText(
                labelKey,
                type: CustomTextType.labelSmall,
                color: CustomTextColor.white,
              ),
            ],
          ),
          const SizedBox(height: 5),
          CustomText(
            value,
            type: CustomTextType.bodyLarge,
            color: CustomTextColor.white,
            translate: false,
          ),
        ],
      ),
    );
  }
}
