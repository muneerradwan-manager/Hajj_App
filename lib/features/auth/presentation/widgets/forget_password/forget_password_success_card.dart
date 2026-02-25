import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/core/localization/app_localizations_setup.dart';
import 'package:hajj_app/shared/widgets/app_card_container.dart';
import 'package:hajj_app/shared/widgets/circular_icon_badge.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';
import 'package:hajj_app/shared/widgets/gradient_elevated_button.dart';
import 'package:hajj_app/shared/widgets/important_note_box.dart';
import 'package:hajj_app/shared/widgets/numbered_steps_list.dart';

class ForgetPasswordSuccessCard extends StatelessWidget {
  const ForgetPasswordSuccessCard({
    super.key,
    required this.email,
    required this.onBackToLogin,
    required this.onResend,
  });

  final String email;
  final VoidCallback onBackToLogin;
  final VoidCallback onResend;

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
            'auth.forget.success_title',
            textAlign: TextAlign.center,
            type: CustomTextType.headlineSmall,
            color: CustomTextColor.red,
          ),
          const SizedBox(height: 10),
          const CustomText(
            'auth.forget.success_subtitle',
            textAlign: TextAlign.center,
            type: CustomTextType.titleSmall,
            color: CustomTextColor.lightRed,
          ),
          const SizedBox(height: 10),
          CustomText(
            email,
            textAlign: TextAlign.center,
            type: CustomTextType.titleSmall,
            color: CustomTextColor.hint,
            translate: false,
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cs.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.secondaryContainer),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CustomText(
                  'auth.forget.next_steps',
                  type: CustomTextType.titleMedium,
                  color: CustomTextColor.red,
                ),
                const SizedBox(height: 10),
                NumberedStepsList(
                  textColor: CustomTextColor.lightRed,
                  steps: [
                    'auth.forget.next_step_1'.tr(context),
                    'auth.forget.next_step_2'.tr(context),
                    'auth.forget.next_step_3'.tr(context),
                    'auth.forget.next_step_4'.tr(context),
                  ],
                ),
                const SizedBox(height: 10),
                const ImportantNoteBox(
                  labelKey: 'auth.forget.important_label',
                  bodyKey: 'auth.forget.important_body',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GradientElevatedButton(
            textKey: 'auth.forget.back_to_login',
            onPressed: onBackToLogin,
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: onResend,
            child: const CustomText(
              'auth.forget.resend',
              type: CustomTextType.titleSmall,
              color: CustomTextColor.green,
            ),
          ),
        ],
      ),
    );
  }
}
