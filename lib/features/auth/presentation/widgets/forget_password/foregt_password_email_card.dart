import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/core/localization/app_localizations_setup.dart';

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
    final textTheme = Theme.of(context).textTheme;

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
            Text(
              'auth.forget.email_card_title'.tr(context),
              textAlign: TextAlign.center,
              style: textTheme.titleLarge?.copyWith(color: cs.tertiary),
            ),
            const SizedBox(height: 6),
            Text(
              'auth.forget.email_card_subtitle'.tr(context),
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(color: cs.errorContainer),
            ),
            const SizedBox(height: 24),
            Text(
              'auth.forget.email_label'.tr(context),
              textAlign: TextAlign.start,
              style: textTheme.titleSmall?.copyWith(color: cs.tertiary),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => onSend?.call(),
              decoration: decoration,
              validator: validateEmail,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              label: Text(
                'auth.forget.send_button'.tr(context),
                style: textTheme.titleMedium?.copyWith(color: cs.onPrimary),
              ),
              onPressed: onSend,
              icon: Icon(LucideIcons.check, size: 18, color: cs.onPrimary),
            ),
            const SizedBox(height: 20),
            Text(
              'auth.forget.send_helper'.tr(context),
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(color: cs.outline),
            ),
          ],
        ),
      ),
    );
  }
}
