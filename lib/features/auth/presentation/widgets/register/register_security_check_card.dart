import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/localization/app_localizations_setup.dart';

class RegisterSecurityCheckCard extends StatelessWidget {
  const RegisterSecurityCheckCard({
    super.key,
    required this.formKey,
    required this.passwordCtrl,
    required this.confirmCtrl,
    required this.qrcodeCtrl,
    required this.onSend,
    required this.onBack,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmCtrl;
  final TextEditingController qrcodeCtrl;
  final VoidCallback? onSend;
  final VoidCallback? onBack;

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
              'auth.register.security_title'.tr(context),
              textAlign: TextAlign.center,
              style: textTheme.titleLarge?.copyWith(color: cs.primary),
            ),
            const SizedBox(height: 6),
            Text(
              'auth.register.security_subtitle'.tr(context),
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: cs.primaryContainer,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'auth.register.password_label'.tr(context),
              textAlign: TextAlign.start,
              style: textTheme.titleSmall?.copyWith(color: cs.primary),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordCtrl,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => onSend?.call(),
              decoration: InputDecoration(
                hintText: 'auth.register.password_hint'.tr(context),
                hintStyle: TextStyle(color: cs.outline),
                suffixIcon: Icon(LucideIcons.eye, color: cs.primary),
              ),
              validator: (value) {
                final text = (value ?? '').trim();
                if (text.isEmpty) {
                  return 'auth.register.validation_password_required'.tr(
                    context,
                  );
                }

                return null;
              },
            ),
            const SizedBox(height: 24),
            Text(
              'auth.register.confirm_password_label'.tr(context),
              textAlign: TextAlign.start,
              style: textTheme.titleSmall?.copyWith(color: cs.primary),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: confirmCtrl,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => onSend?.call(),
              decoration: InputDecoration(
                hintText: 'auth.register.confirm_password_hint'.tr(context),
                hintStyle: TextStyle(color: cs.outline),
                suffixIcon: Icon(LucideIcons.eye, color: cs.primary),
              ),
              validator: (value) {
                final text = (value ?? '').trim();
                if (text.isEmpty) {
                  return 'auth.register.validation_confirm_password_required'
                      .tr(context);
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Text(
              'auth.register.barcode_label'.tr(context),
              textAlign: TextAlign.start,
              style: textTheme.titleSmall?.copyWith(color: cs.primary),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: qrcodeCtrl,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => onSend?.call(),
              decoration: InputDecoration(
                hintText: 'auth.register.barcode_hint'.tr(context),
                hintStyle: TextStyle(color: cs.outline),
                suffixIcon: Icon(LucideIcons.barcode, color: cs.primary),
              ),
              validator: (value) {
                final text = (value ?? '').trim();
                if (text.isEmpty) {
                  return 'auth.register.validation_barcode_required'.tr(
                    context,
                  );
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Text(
              'auth.register.barcode_helper'.tr(context),
              textAlign: TextAlign.start,
              style: textTheme.bodySmall?.copyWith(color: cs.brandGold),
            ),
            const SizedBox(height: 30),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onSend,
                    child: Text(
                      'auth.register.next_button'.tr(context),
                      style: textTheme.titleMedium?.copyWith(
                        color: cs.onPrimary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: cs.primary),
                    ),
                    onPressed: onBack,
                    child: Text(
                      'auth.register.back_button'.tr(context),
                      style: textTheme.titleMedium?.copyWith(color: cs.primary),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
