import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:hajj_app/core/localization/app_localizations_setup.dart';

class RegisterMainInfoCard extends StatelessWidget {
  const RegisterMainInfoCard({
    super.key,
    required this.formKey,
    required this.emailCtrl,
    required this.idCtrl,
    required this.phoneCtrl,
    required this.onSend,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl;
  final TextEditingController idCtrl;
  final TextEditingController phoneCtrl;
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
                child: Icon(LucideIcons.user, color: cs.onPrimary, size: 30),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'auth.register.main_info_title'.tr(context),
              textAlign: TextAlign.center,
              style: textTheme.titleLarge?.copyWith(color: cs.primary),
            ),
            const SizedBox(height: 6),
            Text(
              'auth.register.main_info_subtitle'.tr(context),
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: cs.primary.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'auth.register.email_label'.tr(context),
              textAlign: TextAlign.start,
              style: textTheme.titleSmall?.copyWith(color: cs.primary),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => onSend?.call(),
              decoration: InputDecoration(
                hintText: 'auth.register.email_hint'.tr(context),
                hintStyle: TextStyle(color: cs.outline.withValues(alpha: 0.72)),
                suffixIcon: Icon(LucideIcons.mail, color: cs.primary),
              ),
              validator: (value) {
                final text = (value ?? '').trim();
                if (text.isEmpty) {
                  return 'auth.register.validation_email_required'.tr(context);
                }
                final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                if (!emailRegex.hasMatch(text)) {
                  return 'auth.register.validation_email_invalid'.tr(context);
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Text(
              'auth.register.national_id_label'.tr(context),
              textAlign: TextAlign.start,
              style: textTheme.titleSmall?.copyWith(color: cs.primary),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: idCtrl,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => onSend?.call(),
              decoration: InputDecoration(
                hintText: 'auth.register.national_id_hint'.tr(context),
                hintStyle: TextStyle(color: cs.outline.withValues(alpha: 0.72)),
                suffixIcon: Icon(LucideIcons.user, color: cs.primary),
              ),
              validator: (value) {
                final text = (value ?? '').trim();
                if (text.isEmpty) {
                  return 'auth.register.validation_national_id_required'.tr(
                    context,
                  );
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Text(
              'auth.register.phone_label'.tr(context),
              textAlign: TextAlign.start,
              style: textTheme.titleSmall?.copyWith(color: cs.primary),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => onSend?.call(),
              decoration: InputDecoration(
                hintText: 'auth.register.phone_hint'.tr(context),
                hintStyle: TextStyle(color: cs.outline.withValues(alpha: 0.72)),
                suffixIcon: Icon(LucideIcons.phone, color: cs.primary),
              ),
              validator: (value) {
                final text = (value ?? '').trim();
                if (text.isEmpty) {
                  return 'auth.register.validation_phone_required'.tr(context);
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: onSend,
              child: Text(
                'auth.register.next_button'.tr(context),
                style: textTheme.titleMedium?.copyWith(color: cs.onPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
