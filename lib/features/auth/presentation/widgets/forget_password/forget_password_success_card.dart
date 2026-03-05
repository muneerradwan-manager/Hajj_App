import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/shared/widgets/app_card_container.dart';
import 'package:bawabatelhajj/shared/widgets/circular_icon_badge.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import 'package:bawabatelhajj/shared/widgets/gradient_elevated_button.dart';

class ForgetPasswordSuccessCard extends StatelessWidget {
  const ForgetPasswordSuccessCard({
    super.key,
    required this.email,
    required this.onBackToLogin,
  });

  final String email;
  final VoidCallback onBackToLogin;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AppCardContainer(
      padding: const EdgeInsets.all(17),
      borderColor: cs.primaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CircularIconBadge(
            icon: LucideIcons.check,
            size: 92,
            iconSize: 56,
          ),
          const SizedBox(height: 14),
          const CustomText(
            'auth.forget.reset_success_title',
            textAlign: TextAlign.center,
            type: CustomTextType.headlineSmall,
            color: CustomTextColor.red,
          ),
          const SizedBox(height: 10),
          const CustomText(
            'auth.forget.reset_success_subtitle',
            textAlign: TextAlign.center,
            type: CustomTextType.titleSmall,
            color: CustomTextColor.lightRed,
          ),

          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.primary),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Icon(LucideIcons.lock),
                    CustomText(
                      'auth.forget.reset_success_login_ready',
                      color: CustomTextColor.red,
                      type: CustomTextType.titleLarge,
                    ),
                  ],
                ),
                CustomText(
                  'auth.forget.reset_success_login_hint',
                  color: CustomTextColor.red,
                  type: CustomTextType.labelMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GradientElevatedButton(
            textKey: 'auth.forget.back_to_login',
            onPressed: onBackToLogin,
            gradientColor: GradientColors.green,
          ),
        ],
      ),
    );
  }
}
