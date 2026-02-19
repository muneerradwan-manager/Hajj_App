import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/core/localization/app_localizations_setup.dart';
import 'package:hajj_app/shared/widgets/custom_text.dart';

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
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.primaryContainer),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            child: Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                color: cs.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: cs.shadow.withValues(alpha: 0.22),
                    blurRadius: 16,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: Icon(LucideIcons.check, color: cs.onPrimary, size: 56),
            ),
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
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            decoration: BoxDecoration(
              color: cs.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.secondaryContainer),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      'auth.forget.next_steps',
                      type: CustomTextType.titleMedium,
                      color: CustomTextColor.red,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _ForgetPasswordStepLine(
                  number: 1,
                  text: 'auth.forget.next_step_1'.tr(context),
                ),
                const SizedBox(height: 7),
                _ForgetPasswordStepLine(
                  number: 2,
                  text: 'auth.forget.next_step_2'.tr(context),
                ),
                const SizedBox(height: 7),
                _ForgetPasswordStepLine(
                  number: 3,
                  text: 'auth.forget.next_step_3'.tr(context),
                ),
                const SizedBox(height: 7),
                _ForgetPasswordStepLine(
                  number: 4,
                  text: 'auth.forget.next_step_4'.tr(context),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: cs.outlineVariant),
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'auth.forget.important_label'.tr(context),
                          style: textTheme.titleSmall?.copyWith(
                            color: cs.primary,
                          ),
                        ),
                        TextSpan(
                          text: 'auth.forget.important_body'.tr(context),
                          style: textTheme.bodySmall?.copyWith(
                            color: cs.primary,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [cs.primaryContainer, cs.primary],
              ),
            ),
            child: ElevatedButton(
              onPressed: onBackToLogin,
              child: CustomText(
                'auth.forget.back_to_login',
                type: CustomTextType.titleMedium,
                style: textTheme.titleMedium?.copyWith(color: cs.onPrimary),
              ),
            ),
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

class _ForgetPasswordStepLine extends StatelessWidget {
  const _ForgetPasswordStepLine({required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: CustomText(
            '$number',
            style: textTheme.labelSmall?.copyWith(color: cs.onPrimary),
            translate: false,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CustomText(
            text,
            textAlign: TextAlign.start,
            type: CustomTextType.bodySmall,
            color: CustomTextColor.lightRed,
            translate: false,
          ),
        ),
      ],
    );
  }
}
