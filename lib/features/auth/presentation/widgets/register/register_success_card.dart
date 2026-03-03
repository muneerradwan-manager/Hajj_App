import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:bawabatelhajj/core/localization/app_localizations_setup.dart';
import 'package:bawabatelhajj/shared/widgets/app_card_container.dart';
import 'package:bawabatelhajj/shared/widgets/circular_icon_badge.dart';
import 'package:bawabatelhajj/shared/widgets/custom_text.dart';
import 'package:bawabatelhajj/shared/widgets/gradient_elevated_button.dart';
import 'package:bawabatelhajj/shared/widgets/important_note_box.dart';
import 'package:bawabatelhajj/shared/widgets/numbered_steps_list.dart';

class RegisterSuccessCard extends StatelessWidget {
  const RegisterSuccessCard({super.key, required this.onContinueToLogin});

  final VoidCallback onContinueToLogin;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AppCardContainer(
      padding: const EdgeInsets.all(17),
      borderColor: cs.primaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CircularIconBadge(icon: LucideIcons.check),
          const SizedBox(height: 14),
          const CustomText(
            'auth.register.success_title',
            textAlign: TextAlign.center,
            type: CustomTextType.headlineSmall,
            color: CustomTextColor.green,
          ),
          const SizedBox(height: 10),
          const CustomText(
            'auth.register.success_subtitle',
            textAlign: TextAlign.center,
            type: CustomTextType.titleSmall,
            color: CustomTextColor.green,
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
                  'auth.register.next_steps_title',
                  type: CustomTextType.titleMedium,
                  color: CustomTextColor.green,
                ),
                const SizedBox(height: 10),
                NumberedStepsList(
                  steps: [
                    'auth.register.success_step_1'.tr(context),
                    'auth.register.success_step_2'.tr(context),
                    'auth.register.success_step_3'.tr(context),
                  ],
                ),
                const SizedBox(height: 10),
                const ImportantNoteBox(
                  labelKey: 'auth.register.success_important_label',
                  bodyKey: 'auth.register.success_important_body',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GradientElevatedButton(
            textKey: 'auth.register.go_to_login_button',
            onPressed: onContinueToLogin,
          ),
        ],
      ),
    );
  }
}
