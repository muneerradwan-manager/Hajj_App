import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import 'package:bawabatelhajj/shared/widgets/quick_action_card.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../shared/widgets/custom_container.dart';
import 'closed_action_dialog.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            'home.quick_actions',
            type: CustomTextType.titleMedium,
            color: CustomTextColor.green,
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              const QuickActionCard(
                icon: LucideIcons.bookOpen,
                titleKey: 'home.action_rituals_title',
                borderColor: CustomBorderColor.red,
              ),
              QuickActionCard(
                onTap: () => context.push(AppRoutes.complaintsPath),
                icon: LucideIcons.phone,
                titleKey: 'home.action_complaints_title',
                borderColor: CustomBorderColor.green,
              ),
              QuickActionCard(
                onTap: () => context.push(AppRoutes.evaluationsPath),
                icon: LucideIcons.star,
                titleKey: 'home.action_evaluations_title',
                borderColor: CustomBorderColor.green,
              ),
              QuickActionCard(
                onTap: () => showClosedActionDialog(context),
                icon: LucideIcons.messageSquare,
                titleKey: 'home.action_survey_title',
                borderColor: CustomBorderColor.gold,
              ),
              QuickActionCard(
                onTap: () => showClosedActionDialog(context),
                icon: LucideIcons.award,
                titleKey: 'home.action_certificate_title',
                borderColor: CustomBorderColor.gold,
                isClosed: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
