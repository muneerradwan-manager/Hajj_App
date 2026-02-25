import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';
import 'package:hajj_app/shared/widgets/quick_action_card.dart';

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
                  accentColor: cs.brandRed,
                ),
              ),
              Expanded(
                child: QuickActionCard(
                  icon: LucideIcons.messageSquare,
                  titleKey: 'home.action_survey_title',
                  subtitleKey: 'home.action_survey_subtitle',
                  accentColor: cs.primary,
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
                  accentColor: cs.primary,
                ),
              ),
              Expanded(
                child: QuickActionCard(
                  icon: LucideIcons.messageSquare,
                  titleKey: 'home.action_complaints_title',
                  subtitleKey: 'home.action_complaints_subtitle',
                  accentColor: cs.brandGold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
