import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/core/localization/app_localizations_setup.dart';

class RegisterPasswordSuccessCard extends StatelessWidget {
  const RegisterPasswordSuccessCard({
    super.key,
    required this.onContinueToLogin,
  });

  final VoidCallback onContinueToLogin;

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
          Text(
            'auth.register.success_title'.tr(context),
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(color: cs.primary),
          ),
          const SizedBox(height: 10),
          Text(
            'auth.register.success_subtitle'.tr(context),
            textAlign: TextAlign.center,
            style: textTheme.titleSmall?.copyWith(color: cs.primary),
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
                    Text(
                      'auth.register.next_steps_title'.tr(context),
                      style: textTheme.titleMedium?.copyWith(color: cs.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _RegisterStepLine(
                  number: 1,
                  text: 'auth.register.success_step_1'.tr(context),
                ),
                const SizedBox(height: 7),
                _RegisterStepLine(
                  number: 2,
                  text: 'auth.register.success_step_2'.tr(context),
                ),
                const SizedBox(height: 7),
                _RegisterStepLine(
                  number: 3,
                  text: 'auth.register.success_step_3'.tr(context),
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
                          text: 'auth.register.success_important_label'.tr(
                            context,
                          ),
                          style: textTheme.titleSmall?.copyWith(
                            color: cs.primary,
                          ),
                        ),
                        TextSpan(
                          text: 'auth.register.success_important_body'.tr(
                            context,
                          ),
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
              onPressed: onContinueToLogin,
              child: Text(
                'auth.register.go_to_login_button'.tr(context),
                style: textTheme.titleMedium?.copyWith(color: cs.onPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterStepLine extends StatelessWidget {
  const _RegisterStepLine({required this.number, required this.text});

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
          child: Text(
            '$number',
            style: textTheme.labelSmall?.copyWith(color: cs.onPrimary),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.start,
            style: textTheme.bodySmall?.copyWith(color: cs.primaryContainer),
          ),
        ),
      ],
    );
  }
}
