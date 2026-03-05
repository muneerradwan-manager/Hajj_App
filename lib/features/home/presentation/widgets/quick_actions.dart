import 'package:bawabatelhajj/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import 'package:bawabatelhajj/shared/widgets/quick_action_card.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../shared/widgets/custom_container.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return CustomContainer(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          const CustomText(
            'home.quick_actions',
            type: CustomTextType.titleMedium,
            color: CustomTextColor.green,
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: QuickActionCard(
                  icon: LucideIcons.bookOpen,
                  titleKey: 'home.action_rituals_title',
                  subtitleKey: 'home.action_rituals_subtitle',
                  borderColor: CustomBorderColor.red,
                  containerColor: cs.brandRed,
                ),
              ),
              Expanded(
                child: QuickActionCard(
                  icon: LucideIcons.messageSquare,
                  titleKey: 'home.action_survey_title',
                  subtitleKey: 'home.action_survey_subtitle',
                  borderColor: CustomBorderColor.green,
                  containerColor: cs.primary,
                ),
              ),
            ],
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: QuickActionCard(
                  icon: LucideIcons.award,
                  titleKey: 'home.action_certificate_title',
                  subtitleKey: 'home.action_certificate_subtitle',
                  borderColor: CustomBorderColor.green,
                  containerColor: cs.primary,
                ),
              ),
              Expanded(
                child: QuickActionCard(
                  onTap: () => context.push(AppRoutes.complaintsPath),
                  icon: LucideIcons.messageSquare,
                  titleKey: 'home.action_complaints_title',
                  subtitleKey: 'home.action_complaints_subtitle',
                  borderColor: CustomBorderColor.gold,
                  containerColor: cs.brandGold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
