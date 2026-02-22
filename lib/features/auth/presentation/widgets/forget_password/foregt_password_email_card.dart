import 'package:flutter/material.dart';
import 'package:hajj_app/core/constants/app_colors.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/shared/widgets/custom_text.dart';

class ForgetPasswordEmailCard extends StatelessWidget {
  const ForgetPasswordEmailCard({
    super.key,
    required this.formKey,
    required this.emailCtrl,
    required this.decoration,
    required this.validateEmail,
    required this.onSend,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;
  final InputDecoration decoration;
  final String? Function(String?) validateEmail;
  final VoidCallback? onSend;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: cs.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: cs.shadow.withValues(alpha: 0.2),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(LucideIcons.mail, color: cs.onPrimary, size: 30),
              ),
            ),
            const SizedBox(height: 12),
            const CustomText(
              'auth.forget.email_card_title',
              textAlign: TextAlign.center,
              type: CustomTextType.titleLarge,
              color: CustomTextColor.red,
            ),
            const SizedBox(height: 6),
            const CustomText(
              'auth.forget.email_card_subtitle',
              textAlign: TextAlign.center,
              type: CustomTextType.bodyMedium,
              color: CustomTextColor.gold,
            ),
            const SizedBox(height: 24),
            const CustomText(
              'auth.forget.email_label',
              textAlign: TextAlign.start,
              type: CustomTextType.titleSmall,
              color: CustomTextColor.red,
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: TextStyle(color: Theme.of(context).colorScheme.brandRed),
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => onSend?.call(),
              decoration: decoration.copyWith(
                hintStyle: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.errorContainer.withValues(alpha: .2),
                ),
              ),
              validator: validateEmail,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              label: const CustomText(
                'auth.forget.send_button',
                type: CustomTextType.titleMedium,
                color: CustomTextColor.white,
              ),
              onPressed: onSend,
              icon: Icon(LucideIcons.send, size: 18, color: cs.onPrimary),
            ),
            const SizedBox(height: 20),
            const CustomText(
              'auth.forget.send_helper',
              textAlign: TextAlign.center,
              type: CustomTextType.bodySmall,
              color: CustomTextColor.hint,
            ),
          ],
        ),
      ),
    );
  }
}
